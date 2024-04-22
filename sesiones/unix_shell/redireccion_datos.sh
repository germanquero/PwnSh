#!/bin/bash

# Imprimir mensaje
echo "stdout::Esto es un output normal"

# Imprimir error
echo "stderr::Esto es un error" >&2


echo "stdout::Ingrese input:"
read input

echo "stdout::Se ingreso: ${input}::stdin"

echo "stderr:Cerrando..." >&2
