# Pokedex

### Consideraciones

- Utilizar `make` para ejecutar alias se los programas.
- Es recomendable instalar FVM para no afectar el entorno global. Para más información consultar el siguiente [enlace](https://fvm.app/)

### Comandos

Obtener paquetes

```
~$ make get | fvm flutter pub get
```

Reconstrucción de los modelos 

```
~$ make build | fvm flutter packages pub run build_runner build --delete-conflicting-outputs
```

Ejecución del proyecto

```
~$ make run | fvm flutter run
```

Formato de código

```
~$ make linters
```