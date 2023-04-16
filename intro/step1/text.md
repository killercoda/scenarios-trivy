
Using `trivy`:

Scan images in *Namespaces* `applications` and `infra` for the vulnerabilities `CVE-2021-28831` and `CVE-2016-9841`.

Scale those *Deployments* containing any of these down to `0`.

<br>

<details><summary>Solution</summary>

<br>

First we check the `applications` *Namespace*.

<br>

```
# find images
k -n applications get pod -oyaml | grep image:
```{{exec}}

```
# scan first deployment
trivy image nginx:1.19.1-alpine-perl | grep CVE-2021-28831
trivy image nginx:1.19.1-alpine-perl | grep CVE-2016-9841
```{{exec}}

```
# scan second deployment
trivy image nginx:1.20.2-alpine | grep CVE-2021-28831
trivy image nginx:1.20.2-alpine | grep CVE-2016-9841
```{{exec}}

```
# hit on the first one, so we scale down
k -n applications scale deploy web1 --replicas 0
```{{exec}}

<br>

Next we check the `infra` *Namespace*.

<br>

```
# find images
k -n infra get pod -oyaml | grep image:
```{{exec}}

```
# scan deployment
trivy image httpd:2.4.39-alpine | grep CVE-2021-28831
trivy image httpd:2.4.39-alpine | grep CVE-2016-9841
```{{exec}}

```
# hit, so we scale down
k -n infra scale deploy inf-hjk --replicas 0
```{{exec}}

</details>
