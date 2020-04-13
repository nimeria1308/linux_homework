# Podgotvqne na sredata ----
# Tuk shte napravim neobhodimite stupki,
# za da mojem da testvame komandite po-dolu

# Generirame file-ove, koito posle da se vidqt pri zadachite s tursene
# 1.  Namirate vsichki faylove, koito zapochvat s 6 i imat 2 kato peti znak v imeto si
touch test      # no
touch 5tst2x    # no
touch 6tst3     # no
touch 6tst2     # yes
touch 6xxx2     # yes
touch 6xxx2x    # yes

# 2.  Namirate vsichki faylove, koito zavarshvat na ing i imat proizvolen broy znatsi v imeto si
touch testing   # yes
touch fish      # no
touch fishing   # yes
touch herring   # yes
touch herrings  # no

# 3.  Namirane na vsichki faylove, koito imat v imeto si parvi znak tsifra ot 1 do 5,
#     vtori znak tsifra ot 5 do 9, treti znak bukva ot a do k,
#     chetvarti znak bukva o ili f ili k ili h ili z, peti znak tochka ili )
touch 26gz.     # yes
touch 26gz..    # no
touch 62gz.     # no
touch 55ko\)    # yes
touch 55zo\)    # no
touch 55ki\)    # no

# 4.  Namirate vsichki faylove, koito imat parvi znak v imeto si prazen interval
touch \ test

# 5.  Namirate vsichki faylove, koito imat tochno 20 znaka v imeto si
touch 1234567890123456789   # no
touch 12345678901234567890  # yes
touch 123456789012345678901 # no

# 6.  Namirate vsichki faylove, koito zapochvat s tochka
touch .test # yes

# 7.  Namirate vsichki faylove, koito imat tochka kato chetvarti znak otzad napred v imeto si
touch .321      # yes
touch _321      # no
touch a.321     # yes
touch ab.321    # yes
touch ab3.21    # no
touch ab_321    # no

function cleanup {
    # Premahvame potrebitela Ivan i grupata mu (ako ima takiva)
    sudo userdel Ivan
    sudo groupdel Ivan
}

cleanup

# Prigotvqme promenliva za imeto na output file-a
HW_OUTPUT="linux-3-output.txt"

# Iztrivame output file-a
rm -f ${HW_OUTPUT}

# Zadachi -----------

# Za vsichki operacii za tursene na file-ove chrez `find`,
# pod file razbiram diretorii i file-ove.
# Ako turseneto trqbva da e izrichno samo na file-ove,
# trqbva da se dobavi `-type f` sled file patter-na:
# primerno, za da ne vrushta i '.' v zadacha 6.

# Shte pochnem ot vupros 18., tai kato toi se polzva vav vsichkite

# 18. Zapisva rezultata ot vsyaka operatsiya vav fayl. Predstavete tozi fayl zaedno s resheniyata.
echo "Zadacha 18." |& tee -a ${HW_OUTPUT}

# Prosto shte pipe-nem dadenata kommanda vav ${HW_OUTPUT}
# Za celta obache shte polzvame `tee`, za da se otpechata rezultata i v konzolata,
# i vav file-a. Shte podadem opcia `-a` (--append), za da ne prezapisvame file-a,
# a da dobavqme kum kraq mu
echo primerna komanda |& tee -a ${HW_OUTPUT}

# 1.  Namirate vsichki faylove, koito zapochvat s 6 i imat 2 kato peti znak v imeto si
echo "Zadacha 1." |& tee -a ${HW_OUTPUT}
find -name "6???2*" |& tee -a ${HW_OUTPUT}

# 2.  Namirate vsichki faylove, koito zavarshvat na ing i imat proizvolen broy znatsi v imeto si
echo "Zadacha 2." |& tee -a ${HW_OUTPUT}
find -name "*ing" |& tee -a ${HW_OUTPUT}

# 3.  Namirane na vsichki faylove, koito imat v imeto si parvi znak tsifra ot 1 do 5,
#     vtori znak tsifra ot 5 do 9, treti znak bukva ot a do k,
#     chetvarti znak bukva o ili f ili k ili h ili z, peti znak tochka ili )
echo "Zadacha 3." |& tee -a ${HW_OUTPUT}
find -name "[1-5][5-9][a-k][ofkhz][\.\)]" |& tee -a ${HW_OUTPUT}

# 4.  Namirate vsichki faylove, koito imat parvi znak v imeto si prazen interval
echo "Zadacha 4." |& tee -a ${HW_OUTPUT}
find -name " *" |& tee -a ${HW_OUTPUT}

# 5.  Namirate vsichki faylove, koito imat tochno 20 znaka v imeto si
echo "Zadacha 5." |& tee -a ${HW_OUTPUT}
find -name "????????????????????" |& tee -a ${HW_OUTPUT}

# 6.  Namirate vsichki faylove, koito zapochvat s tochka
echo "Zadacha 6." |& tee -a ${HW_OUTPUT}
find -name ".*" |& tee -a ${HW_OUTPUT}

# 7.  Namirate vsichki faylove, koito imat tochka kato chetvarti znak otzad napred v imeto si
echo "Zadacha 7." |& tee -a ${HW_OUTPUT}
find -name "*.???" |& tee -a ${HW_OUTPUT}

# 8.  Otpechatate palnite patishta do vsichki faylove v tekushtata direktoriya

# Mojem da go reazlirame chrez ls i find
# I v dvata sluchaq, shte polzvame readlink za da ni dade absolutnia pat

echo "Zadacha 8. (ls)" |& tee -a ${HW_OUTPUT}
ls -r -1 | xargs readlink -f |& tee -a ${HW_OUTPUT}

echo "Zadacha 8. (find)" |& tee -a ${HW_OUTPUT}
find | xargs readlink -f |& tee -a ${HW_OUTPUT}

# Shte izpulnim 10. predi 9., tai kato taka mojem da go testvame localno

# 10. Tarsene na akaunt s ime Ivan  i sazdavaneto mu, ako ne sashtestvuva   
echo "Zadacha 10." |& tee -a ${HW_OUTPUT}

# Da proverim dali ima takuv account (vijte obqsnenieto za getent i passwd kum vupros 9.)
getent passwd Ivan

# Ako ima greshka, znachi ne sushtestvuva i shte go suzdadem
if [[ $? != 0 ]]
then
    echo "Niama potrebitel Ivan, shte go sazdadem" |& tee -a ${HW_OUTPUT}
    sudo useradd Ivan |& tee -a ${HW_OUTPUT}
fi

# 9.  Proveryava dali tezi potrebitel Ivan ima nyakakvi faylove v darvoto na direktoriite i dokumentira namerenoto
echo "Zadacha 9." |& tee -a ${HW_OUTPUT}

# $ getent passwd simona
#   simona:x:1000:1000:,,,:/home/simona:/bin/bash
#
# Kakto se vijda, poletata sa razdeleni s ':', i 6-toto pole e directoriata na usera
# mojem da polzvame `cut`, za da razdelim resultata po ':' i da vzemem 6-tata kolona
#
# $ getent passwd simona | cut -d: -f6
#   /home/simona

# Za po-lesno neka da zapazim home_dir i nomera na user-a (shte ni trqbva posle) v promenlivi
USER_IVAN_HOME_DIR=`getent passwd Ivan | cut -d: -f6`
USER_IVAN_UID=`getent passwd Ivan | cut -d: -f3`

# Vzimame home dir na Ivan i q podavame na find, i broim broq namereni files,
# za da vidim ima li i kolko file-ove
echo "Number of files: `find ${USER_IVAN_HOME_DIR} | wc -l`" |& tee -a ${HW_OUTPUT}
find "${USER_IVAN_HOME_DIR}" |& tee -a ${HW_OUTPUT}

# 11. Sabira vsichki faylove na potrebitel Ivan v poddirektoriya /root/archive/ime na potrebitelya i nomera mu
echo "Zadacha 11." |& tee -a ${HW_OUTPUT}

# Tova shte fail-ne za root prava v /, kakto i lipsa na realna home direktoria za `Ivan`
# obache ne mi se zanimava da pravq testovi danni za vsichkite tezi direktorii...
cp -a "${USER_IVAN_HOME_DIR}" "/root/archive/Ivan_${USER_IVAN_UID}" |& tee -a ${HW_OUTPUT}

# 12. Smenya sobstvenostta na potrebitel Ivan kam root
echo "Zadacha 12. (root)" |& tee -a ${HW_OUTPUT}

echo "Ivan original group: `getent group \`getent passwd Ivan | cut -d: -f4\` | cut -d: -f1`" |& tee -a ${HW_OUTPUT}
sudo usermod -g root Ivan |& tee -a ${HW_OUTPUT}
echo "Ivan new group: `getent group \`getent passwd Ivan | cut -d: -f4\` | cut -d: -f1`" |& tee -a ${HW_OUTPUT}

# no po-princip e po-pravilno da dobavim Ivan kum sudo grupata, vmesto da mu smenqme grupata diretno

# vrushtame mu grupata
echo "Zadacha 12. (sudo)" |& tee -a ${HW_OUTPUT}
sudo usermod -g Ivan Ivan |& tee -a ${HW_OUTPUT}

# i go dobavqme kum sudo
sudo usermod -aG sudo Ivan |& tee -a ${HW_OUTPUT}
getent group sudo |& tee -a ${HW_OUTPUT}

# 13. Zapisva imenata na vsichki protsesi i gi otpechatva samo s glavni bukvi
echo "Zadacha 13." |& tee -a ${HW_OUTPUT}

# za `ps` polzvame:
#   -e za list na vsichki processi
#   -o za izbirane na output format, kato mu davame comm,
#      za da pokaje imeto na procesa (command shte vurne i
#      s kakvi parametri e izvikan executable-a),
#      kato preimenuvame kolonata na prazen string,
#      za da q premahnem ot rezultata
# polzvame `tr` za da preobrazuvame (translate) a-z v A-Z
ps -e -o comm= | tr a-z A-Z |& tee -a ${HW_OUTPUT}

# 14. Tarsi i sortira protsesite po nomer na roditelskiya protses
echo "Zadacha 14. (samo printirame sortirano)" |& tee -a ${HW_OUTPUT}
ps -e --sort=ppid |& tee -a ${HW_OUTPUT}

# Ako iskame da filtrirame rezultatite samo za decata na opredelen process
# shte dobavim --ppid=1741
echo "Zadacha 14. (filterirame po ppid)" |& tee -a ${HW_OUTPUT}
ps --sort=ppid --ppid=1741 |& tee -a ${HW_OUTPUT}

# 15. Otpechatvane na protsesite v dve koloni

# Ako stava duma za pokazvane samo na PID i COMM
echo "Zadacha 15 (pid + comm)." |& tee -a ${HW_OUTPUT}
ps -e -o pid,comm |& tee -a ${HW_OUTPUT}

# Ako stava duma za pechatane samo na comm,
# no razultatite da se pokzvat v 2 koloni
echo "Zadacha 15 (comm v 2 coloni)." |& tee -a ${HW_OUTPUT}
ps -e -o comm= | pr -2 -t |& tee -a ${HW_OUTPUT}

# 16. Sortirane na protsesite po imeto na protsesa
echo "Zadacha 16." |& tee -a ${HW_OUTPUT}
ps -e --sort=comm |& tee -a ${HW_OUTPUT}

# 17. Prebroyte protsesite
echo "Zadacha 17." |& tee -a ${HW_OUTPUT}
ps -e -o pid= | wc -l |& tee -a ${HW_OUTPUT}

cleanup
