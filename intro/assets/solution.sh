#!/bin/bash

kubectl -n applications scale deploy web1 --replicas 0

kubectl -n infra scale deploy inf-hjk --replicas 0
