# libasm

Projet de l'école **42** : réimplémentation en **assembleur x86-64** (syntaxe **NASM**) de fonctions classiques de la bibliothèque C standard.

L'objectif est de comprendre la convention d'appel **System V AMD64**, l'interaction avec le noyau Linux via les **syscalls**, et la manipulation bas niveau des chaînes de caractères en mémoire.

## Fonctions implémentées

| Fonction | Fichier | Description |
|----------|---------|-------------|
| `ft_strlen` | `ft_strlen.s` | Calcule la longueur d'une chaîne |
| `ft_strcpy` | `ft_strcpy.s` | Copie une chaîne dans un buffer |
| `ft_strcmp` | `ft_strcmp.s` | Compare deux chaînes |
| `ft_strdup` | `ft_strdup.s` | Duplique une chaîne en mémoire |
| `ft_write` | `ft_write.s` | Écrit sur un descripteur de fichier |
| `ft_read` | `ft_read.s` | Lit depuis un descripteur de fichier |

Les prototypes sont déclarés dans `libasm.h`.

## Compilation

Prérequis : `nasm`, `gcc`, `make`, `ar`.

```bash
make        # compile les .s et crée libasm.a
make test   # compile main.c, lie la lib et lance les tests
make clean  # supprime les .o
make fclean # supprime les .o, libasm.a et le binaire de test
make re     # recompile tout depuis zéro
```

## Tests

Un fichier `main.c` et un `test.txt` sont fournis pour tester chaque fonction.

```bash
make test
```

Le programme affiche les résultats de `ft_read`, `ft_write`, `ft_strlen`, `ft_strcmp`, `ft_strcpy` et `ft_strdup`.

## Convention d'appel (System V AMD64)

Sur Linux x86-64, les arguments d'une fonction C sont passés dans cet ordre :

| Paramètre | Registre |
|-----------|----------|
| 1er | `rdi` |
| 2e | `rsi` |
| 3e | `rdx` |
| 4e | `rcx` |
| 5e | `r8` |
| 6e | `r9` |

La valeur de retour est placée dans `rax`.

## Fonctionnement de chaque fonction

### `ft_read(int fd, char *buf, size_t count)`

Appelle le syscall `read` (numéro `0` dans `rax`).

- `rdi` = fd
- `rsi` = buffer
- `rdx` = nombre d'octets à lire

Après le `syscall`, si `rax < 0`, la fonction retourne `-1` (erreur). Sinon, elle retourne le nombre d'octets lus.

### `ft_write(int fd, char *buf, size_t count)`

Appelle le syscall `write` (numéro `1` dans `rax`).

- `rdi` = fd
- `rsi` = buffer
- `rdx` = nombre d'octets à écrire

Si le carry flag est activé après le syscall (`jc`), la fonction retourne `-1`. Sinon, elle retourne le nombre d'octets écrits.

### `ft_strlen(char *s)`

Parcourt la chaîne caractère par caractère jusqu'au `'\0'`.

- `rdi` = pointeur vers la chaîne
- `rax` = compteur (incrémenté à chaque caractère lu)

Retourne la longueur dans `rax`.

### `ft_strcpy(char *dest, char *src)`

Copie `src` dans `dest`, octet par octet, jusqu'au `'\0'` inclus.

- `rdi` = destination
- `rsi` = source
- `rax` = index de parcours
- `bl` = octet temporaire (utilisé pour ne pas écraser l'index dans `rax`)

Retourne le pointeur `dest` (`rdi`) dans `rax`.

### `ft_strcmp(char *s1, char *s2)`

Compare deux chaînes caractère par caractère.

- `rdi` = première chaîne
- `rsi` = deuxième chaîne
- `rcx` = index de parcours

La boucle s'arrête dès qu'un caractère diffère ou qu'un `'\0'` est atteint. À la fin, la fonction retourne la différence entre les deux octets (`s1[i] - s2[i]`) dans `rax`, comme `strcmp` de la libc.

### `ft_strdup(char *s)`

Réutilise les fonctions déjà écrites :

1. Appelle `ft_strlen` pour obtenir la taille
2. Alloue `taille + 1` octets avec `malloc`
3. Si `malloc` échoue, retourne `NULL`
4. Sauvegarde la source sur la pile (`push rdi`)
5. Appelle `ft_strcpy` pour copier la chaîne dans la zone allouée
6. Retourne le pointeur alloué

## Structure du projet

```
libasm/
├── libasm.h        # prototypes des fonctions
├── ft_*.s          # implémentations en assembleur
├── main.c          # programme de test
├── test.txt        # fichier lu par ft_read
├── Makefile        # règles de compilation
└── README.md
```

## Notes techniques

- Assembleur : **NASM** (`-f elf64`)
- Architecture : **x86-64 Linux**
- La bibliothèque est archivée dans `libasm.a` (format statique)
- `ft_strdup` est la seule fonction qui appelle du code C externe (`malloc`) et d'autres fonctions de la lib (`ft_strlen`, `ft_strcpy`)
