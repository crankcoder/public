#!/bin/bash

mkdir overlays

cat istio_operator.yaml | \
    yq 'del(.items[].metadata.creationTimestamp)' | \
    yq 'del(.items[].metadata.generation)' | \
    yq '.items[]' -s '"./overlays/overlay_" + .metadata.name + ".yaml"'


COMMAND="\\"
for f in overlays/*
do
    [ -e "$f" ] || continue
    COMMAND="--custom_overlay $f $COMMAND"
done

echo $COMMAND




rm -rf overlays

