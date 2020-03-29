# 1. pet opcii na ls

# -a, --all
# Pokazva i file-ovete / directorii zapochvashti s tochka,
# naprimer .. (za po-gorna directoria) ili
# "skriti" (ne v smisula attributa v Windows, a takiva koito ne se pokazva po podrazbirane)
# file-ove / directorii kato .bashrc, .config, .git i tn
ls -a

# -l
# vseki file/directoria se izpisva na otdelen red s detail
# naprimer prava, owner, grupa, razmer, data na suzdavane i tn
ls -l

# -F, --classify
# Ukazva tipa file, kato dobavq pred imeto mu specialen znak,
# naprimer * za executable bit i tn
ls -F

# -1
# Printira edin file/directoria na red i to samo imeto
# Udobno za scriptove
ls -1

# -h, --human-readable
# Kogato se izpolzva dulgia format s detail (-l), izpisva file-ovite
# razmeri v po-lesen za chetene format, vmesto v bytes: (30M naprimer)
ls -lh

# 2. pet opcii na cp

# Purvo prigotvqme danni za testa
mkdir -p cp_test
touch cp_test/test

# -v, --verbose
# izpisvat se v realno vreme kopiranite file-ove
cp -v cp_test/test test_2

# -i, --interactive
# Ako veche sushtestvuva file s imeto s koeto iskame da
# go kopirame, se iziskva potvurjdenie ot potrebitelq

# Nqma test_3 i nqma da se pita potrebitelq
cp -i cp_test/test test_3

# Veche ima test_2 i potrebitelq shte bude
# popitan da potvurdi prezapisvaneto mu
cp -i cp_test/test test_2

# -r, -R, --recursive
# Recursivno kopira directoria s neinite 
# file-ove i pod-directorii

# Narochno dobavih -v, za da se pokaje
# operaciata ot kopiraneto na direktoria
cp -rv cp_test/ cp_test_2/

# -u, --update
# Kopira file-a samo ako vremeto na obnovqvane
# na iztochnika e po-novo ot destinaciata
# Udobno pri pravene na arhivi

# V suclhaq pak dobavih -v, za da se vidi
# koe shte se kopira i koe ne

# Nqma da se kopira nishto, sushtestvuvashtia
# file test_2 e sas sushtata timestampa kato
# cp_test/test
cp -uv cp_test/test test_2

# neka obnovim vremeto na posledna promqna
# v iztochnika
touch cp_test/test
# sega kopirane shte nastupi, tai kato
# iztochnikat e po-nov
cp -uv cp_test/test test_2

# -a, --archive
# sushtoto kato -dR --preserve=all
# toest kopira rekursivno, kato zapazva simvolichnite linkove
# kakto i atributite na file-ovete, t.e. prava,
# na koi user/grupa prinadleji, timestampi za vreme na
# suzdavane / posledno obnovqvane i tn.
#
# polzva se za arhivirane na celi directorii
cp -a cp_test/ cp_test_3/

# 3. Directoria s tri poddirectorii v neq
mkdir -p test_dir/1
mkdir -p test_dir/2
mkdir -p test_dir/3

# 4. Copyrane ot po-gorna kam directoriite
# Purvo da si suzdadem nqkolko
mkdir -p ../test
touch ../test/test_1
touch ../test/test_2
cp ../test/* test_dir/1/

# 5. simvolichen link
ln -s test_dir/1/test_1

# 6. Iztrivame test_dir zaedno s neinoto sadajanie
rm -rf test_dir/

# Za sledvashtite zadachi shte suzdadem nqkolko
# testovi file-a i directorii, za da mojem da
# testvame komandite
touch xyz .test .lotest .verylongtest
mkdir -p .test_dir/1/2/3
touch raaa rabp paar .test_dir/x .test_dir/rxxxxxp .test_dir/1/2/3/rabcp
touch a\) A0123\) b4\) c56\) d78
touch a ab
touch ".test_dir/1/2/ "

# 7. file-ove zapochvashti s . i s do 7 znaka (vkl. tochkata)
find -name '.' -o -name '.?' -o -name '.??' -o -name '.???' -o -name '.???' -o -name '.????' -o -name '.?????' -o -name '.??????'

# 8. file-ove zapochvashti s r i zavurvashti s p
find -name 'r*p'

# 9. file-ove zapochvashti s malka bukva, s pone edna cifra i zavurshvashti s )
find -name '[a-z]*[0-9]*)'

# 10. file-ove s ime tochno dva znaka, no bez ..
find -name '??'

# Proverete ima li file s ime prazen interval
find -name ' '
