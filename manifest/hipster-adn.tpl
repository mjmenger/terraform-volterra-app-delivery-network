# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# ----------------------------------------------------------
# WARNING: This file is autogenerated. Do not manually edit.
# ----------------------------------------------------------

apiVersion: apps/v1
kind: Deployment
metadata:
  name: emailservice
  annotations:
    ves.io/workload-flavor: medium
spec:
  selector:
    matchLabels:
      app: emailservice
  template:
    metadata:
      labels:
        app: emailservice
    spec:
      terminationGracePeriodSeconds: 5
      containers:
      - name: server
        image: gcr.io/google-samples/microservices-demo/emailservice:v0.1.2
        ports:
        - containerPort: 8080
        env:
        - name: PORT
          value: "8080"
        readinessProbe:
          periodSeconds: 5
          exec:
            command: ["/bin/grpc_health_probe", "-addr=:8080"]
        livenessProbe:
          periodSeconds: 5
          exec:
            command: ["/bin/grpc_health_probe", "-addr=:8080"]
        env:
        - name: ENABLE_PROFILER
          value: "0"
---
apiVersion: v1
kind: Service
metadata:
  name: emailservice
  labels:
    app: emailservice
  annotations:
    ves.io/proxy-type: HTTP_PROXY
    ves.io/http2-enable: "true"
spec:
  type: ClusterIP
  selector:
    app: emailservice
  ports:
  - name: grpc
    port: 5000
    targetPort: 8080
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: paymentservice
  annotations:
    ves.io/workload-flavor: medium
spec:
  selector:
    matchLabels:
      app: paymentservice
  template:
    metadata:
      labels:
        app: paymentservice
    spec:
      terminationGracePeriodSeconds: 5
      containers:
      - name: server
        image: gcr.io/google-samples/microservices-demo/paymentservice:v0.1.2
        ports:
        - containerPort: 50051
        env:
        - name: PORT
          value: "50051"
        readinessProbe:
          exec:
            command: ["/bin/grpc_health_probe", "-addr=:50051"]
        livenessProbe:
          exec:
            command: ["/bin/grpc_health_probe", "-addr=:50051"]
---
apiVersion: v1
kind: Service
metadata:
  name: paymentservice
  labels:
    app: paymentservice
  annotations:
    ves.io/proxy-type: HTTP_PROXY
    ves.io/http2-enable: "true"
spec:
  type: ClusterIP
  selector:
    app: paymentservice
  ports:
  - name: grpc
    port: 50051
    targetPort: 50051
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: productcatalogservice
  annotations:
    ves.io/workload-flavor: medium
spec:
  selector:
    matchLabels:
      app: productcatalogservice
  template:
    metadata:
      labels:
        app: productcatalogservice
    spec:
      terminationGracePeriodSeconds: 5
      containers:
      - name: server
        image: gcr.io/google-samples/microservices-demo/productcatalogservice:v0.1.2
        ports:
        - containerPort: 3550
        env:
        - name: PORT
          value: "3550"
        readinessProbe:
          exec:
            command: ["/bin/grpc_health_probe", "-addr=:3550"]
        livenessProbe:
          exec:
            command: ["/bin/grpc_health_probe", "-addr=:3550"]
---
apiVersion: v1
kind: Service
metadata:
  name: productcatalogservice
  labels:
    app: productcatalogservice
  annotations:
    ves.io/proxy-type: HTTP_PROXY
    ves.io/http2-enable: "true"
spec:
  type: ClusterIP
  selector:
    app: productcatalogservice
  ports:
  - name: grpc
    port: 3550
    targetPort: 3550
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: cartservice
  annotations:
    ves.io/workload-flavor: medium
spec:
  selector:
    matchLabels:
      app: cartservice
  template:
    metadata:
      labels:
        app: cartservice
    spec:
      terminationGracePeriodSeconds: 5
      containers:
      - name: server
        image: volterrademos/cartservice:latest
        ports:
        - containerPort: 7070
        env:
        - name: REDIS_ADDR
          value: "redis-cart:6379"
        - name: PORT
          value: "7070"
        - name: LISTEN_ADDR
          value: "0.0.0.0"
        readinessProbe:
          initialDelaySeconds: 15
          exec:
            command: ["/bin/grpc_health_probe", "-addr=:7070", "-rpc-timeout=5s"]
        livenessProbe:
          initialDelaySeconds: 15
          periodSeconds: 10
          exec:
            command: ["/bin/grpc_health_probe", "-addr=:7070", "-rpc-timeout=5s"]
---
apiVersion: v1
kind: Service
metadata:
  name: cartservice
  labels:
    app: cartservice
  annotations:
    ves.io/proxy-type: HTTP_PROXY
    ves.io/http2-enable: "true"
spec:
  type: ClusterIP
  selector:
    app: cartservice
  ports:
  - name: grpc
    port: 7070
    targetPort: 7070
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: currencyservice
  annotations:
    ves.io/workload-flavor: medium
spec:
  selector:
    matchLabels:
      app: currencyservice
  template:
    metadata:
      labels:
        app: currencyservice
    spec:
      terminationGracePeriodSeconds: 5
      containers:
      - name: server
        image: gcr.io/google-samples/microservices-demo/currencyservice:v0.1.2
        ports:
        - name: grpc
          containerPort: 7000
        env:
        - name: PORT
          value: "7000"
        readinessProbe:
          exec:
            command: ["/bin/grpc_health_probe", "-addr=:7000"]
        livenessProbe:
          exec:
            command: ["/bin/grpc_health_probe", "-addr=:7000"]
---
apiVersion: v1
kind: Service
metadata:
  name: currencyservice
  labels:
    app: currencyservice
  annotations:
    ves.io/proxy-type: HTTP_PROXY
    ves.io/http2-enable: "true"
spec:
  type: ClusterIP
  selector:
    app: currencyservice
  ports:
  - name: grpc
    port: 7000
    targetPort: 7000
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: shippingservice
  annotations:
    ves.io/workload-flavor: medium
spec:
  selector:
    matchLabels:
      app: shippingservice
  template:
    metadata:
      labels:
        app: shippingservice
    spec:
      containers:
      - name: server
        image: gcr.io/google-samples/microservices-demo/shippingservice:v0.1.2
        ports:
        - containerPort: 50051
        env:
        - name: PORT
          value: "50051"
        readinessProbe:
          periodSeconds: 5
          exec:
            command: ["/bin/grpc_health_probe", "-addr=:50051"]
        livenessProbe:
          exec:
            command: ["/bin/grpc_health_probe", "-addr=:50051"]
---
apiVersion: v1
kind: Service
metadata:
  name: shippingservice
  labels:
    app: shippingservice
  annotations:
    ves.io/proxy-type: HTTP_PROXY
    ves.io/http2-enable: "true"
spec:
  type: ClusterIP
  selector:
    app: shippingservice
  ports:
  - name: grpc
    port: 50051
    targetPort: 50051
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: recommendationservice
  annotations:
    ves.io/workload-flavor: medium
spec:
  selector:
    matchLabels:
      app: recommendationservice
  template:
    metadata:
      labels:
        app: recommendationservice
    spec:
      terminationGracePeriodSeconds: 5
      containers:
      - name: server
        image: gcr.io/google-samples/microservices-demo/recommendationservice:v0.1.2
        ports:
        - containerPort: 8080
        readinessProbe:
          periodSeconds: 5
          exec:
            command: ["/bin/grpc_health_probe", "-addr=:8080"]
        livenessProbe:
          periodSeconds: 5
          exec:
            command: ["/bin/grpc_health_probe", "-addr=:8080"]
        env:
        - name: PORT
          value: "8080"
        - name: PRODUCT_CATALOG_SERVICE_ADDR
          value: "productcatalogservice:3550"
        - name: ENABLE_PROFILER
          value: "0"
---
apiVersion: v1
kind: Service
metadata:
  name: recommendationservice
  labels:
    app: recommendationservice
  annotations:
    ves.io/proxy-type: HTTP_PROXY
    ves.io/http2-enable: "true"
spec:
  ports:
    - name: grpc
      protocol: TCP
      port: 8089
      targetPort: 8080
  selector:
    app: recommendationservice
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: checkoutservice
spec:
  selector:
    matchLabels:
      app: checkoutservice
  template:
    metadata:
      labels:
        app: checkoutservice
    spec:
      containers:
        - name: server
          image: gcr.io/google-samples/microservices-demo/checkoutservice:v0.1.2
          ports:
          - containerPort: 5050
          readinessProbe:
            exec:
              command: ["/bin/grpc_health_probe", "-addr=:5050"]
          livenessProbe:
            exec:
              command: ["/bin/grpc_health_probe", "-addr=:5050"]
          env:
          - name: PORT
            value: "5050"
          - name: PRODUCT_CATALOG_SERVICE_ADDR
            value: "productcatalogservice:3550"
          - name: SHIPPING_SERVICE_ADDR
            value: "shippingservice:50051"
          - name: PAYMENT_SERVICE_ADDR
            value: "paymentservice:50051"
          - name: EMAIL_SERVICE_ADDR
            value: "emailservice:5000"
          - name: CURRENCY_SERVICE_ADDR
            value: "currencyservice:7000"
          - name: CART_SERVICE_ADDR
            value: "cartservice:7070"
---
apiVersion: v1
kind: Service
metadata:
  name: checkoutservice
  labels:
    app: checkoutservice
  annotations:
    ves.io/proxy-type: HTTP_PROXY
    ves.io/http2-enable: "true"
spec:
  type: ClusterIP
  selector:
    app: checkoutservice
  ports:
  - name: grpc
    port: 5050
    targetPort: 5050
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: frontend
spec:
  selector:
    matchLabels:
      app: frontend
  template:
    metadata:
      labels:
        app: frontend
    spec:
      containers:
        - name: server
          image: madhukar32/hipster-frontend:latest
          ports:
          - containerPort: 8080
          env:
          - name: PORT
            value: "8080"
          - name: PRODUCT_CATALOG_SERVICE_ADDR
            value: "productcatalogservice:3550"
          - name: CURRENCY_SERVICE_ADDR
            value: "currencyservice:7000"
          - name: CART_SERVICE_ADDR
            value: "cartservice:7070"
          - name: RECOMMENDATION_SERVICE_ADDR
            value: "recommendationservice:8089"
          - name: SHIPPING_SERVICE_ADDR
            value: "shippingservice:50051"
          - name: CHECKOUT_SERVICE_ADDR
            value: "checkoutservice:5050"
          - name: AD_SERVICE_ADDR
            value: "adservice:9555"
---
apiVersion: v1
kind: Service
metadata:
  name: frontend
  annotations:
    ves.io/proxy-type: HTTP_PROXY
  labels:
    app: frontend
    svc_name: frontend
spec:
  selector:
    app: frontend
  ports:
  - name: frontend
    port: 80
    targetPort: 8080
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: redis-cart
spec:
  selector:
    matchLabels:
      app: redis-cart
  replicas: 1
  template:
    metadata:
      labels:
        app: redis-cart
    spec:
      containers:
      - name: master
        image: k8s.gcr.io/redis:e2e  # or just image: redis
        resources:
          requests:
            cpu: 100m
            memory: 200Mi
        ports:
        - containerPort: 6379
        volumeMounts:
        - mountPath: /data
          name: redis-data
        resources:
          limits:
            memory: 256Mi
            cpu: 125m
          requests:
            cpu: 70m
            memory: 200Mi
      volumes:
      - name: redis-data
        emptyDir: {}
---
apiVersion: v1
kind: Service
metadata:
  name: redis-cart
spec:
  type: ClusterIP
  selector:
    app: redis-cart
  ports:
  - name: redis
    port: 6379
    targetPort: 6379
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: loadgenerator
  annotations:
    ves.io/sites: ves-io-system/ny8-nyc
spec:
  selector:
    matchLabels:
      app: loadgenerator
  replicas: 1
  template:
    metadata:
      labels:
        app: loadgenerator
        ves.io/app: loadgenerator
        ves.io/app_type: ${namespace}
      annotations:
        sidecar.istio.io/rewriteAppHTTPProbers: "true"
    spec:
      terminationGracePeriodSeconds: 5
      restartPolicy: Always
      containers:
      - name: main
        image: gcr.io/google-samples/microservices-demo/loadgenerator:v0.2.0
        env:
        - name: FRONTEND_ADDR
          value: "frontend:80"
        - name: USERS
          value: "10"
        resources:
          requests:
            cpu: 300m
            memory: 256Mi
          limits:
            cpu: 500m
            memory: 512Mi