# Podgotvqne na sredata ----
# Tuk shte napravim neobhodimite stupki,
# za da mojem da testvame komandite po-dolu

# polzvame za skeleton directory na user-ite
mkdir -p user_test/test
touch user_test/test1 user_test/test/test2

# suzdavame file-ove koito ne prinadlejat na nikogo
# toest na nito edin/edna ot izvestnite useri/grupi
# za celta shte slojim za owner-i nevalidni user/grupa
mkdir bad_dir
touch bad_file_1 bad_file_2 bad_dir/bad_file3
sudo chown 123456:123456 bad_file_* bad_dir/bad_file3

# suzdavame testov user
function create_test_user {
    # dobavqme user-a
    # suzdavame mu home directory (-m)
    # copyrame file-ovete ot skeleton directoriata (-k) v home
    sudo useradd "${1}" -m -k user_test
}

function remove_test_user {
    sudo userdel "${1}" --remove
    sudo groupdel "${1}"
}

function cleanup {
    remove_test_user "TempClient1"
    remove_test_user "TempClient2"
    remove_test_user "TempDummy"
    remove_test_user "MasterClient"
    sudo groupdel Clients
    sudo rm -rf /tmp/test_dirs/

    # neka se vurnem na redaktorat po podrazbirane za systemata
    sudo update-alternatives --auto editor
}

cleanup
create_test_user "TempClient1"
create_test_user "TempClient2"
create_test_user "Dummy" # Not a client

# Prigotvqme promenliva za imeto na output file-a
HW_OUTPUT="linux-4-output.txt"

# Zadachi -----------

# 1.  Namirate vsichki akaunti na potrebiteli, koito imat v imeto si client.
echo "Zadacha 1." |& tee -a ${HW_OUTPUT}

# za celta printirame informaciata za vsichki user-i,
# vzimame purvoto pole (username) i tursim za client (ignore case)
getent passwd | cut -d: -f1 | grep -i ".*client.*" |& tee -a ${HW_OUTPUT}

# 2.  Napravete direktorii na namerenite potrebiteli otdelno ot tehnite home direktorii.
echo "Zadacha 2." |& tee -a ${HW_OUTPUT}

# obikaliame potrebitelite
for u in `getent passwd | cut -d: -f1 | grep -i ".*client.*"`
do
    # suzdavame direktoriata
    mkdir -p "/tmp/test_dirs/$u" |& tee -a ${HW_OUTPUT}

    # opravqme sobstvenostta im
    sudo chown "$u":"$u" -R "/tmp/test_dirs/$u" |& tee -a ${HW_OUTPUT}
done

ls -l "/tmp/test_dirs/" |& tee -a ${HW_OUTPUT}

# 3.  Kopirayte vsichki faylove na tezi potrebiteli v novite im direktorii.
echo "Zadacha 3." |& tee -a ${HW_OUTPUT}

# obikaliame potrebitelite
for u in `getent passwd | cut -d: -f1 | grep -i ".*client.*"`
do
    # vzimame home direktoriata (pole 6 ot passwd)
    # kopirame v novata direktoria kato zapazvame atributite
    sudo cp -a "`getent passwd $u | cut -d: -f6`" "/tmp/test_dirs/$u" |& tee -a ${HW_OUTPUT}
done

# 4.  Sazdayte akaunt na potrebitel MasterClient.
echo "Zadacha 4." |& tee -a ${HW_OUTPUT}
sudo useradd MasterClient |& tee -a ${HW_OUTPUT}
getent passwd MasterClient |& tee -a ${HW_OUTPUT}

# 5.  Sazdayte grupa Clients.
echo "Zadacha 5." |& tee -a ${HW_OUTPUT}
sudo groupadd Clients |& tee -a ${HW_OUTPUT}
getent group Clients |& tee -a ${HW_OUTPUT}

# 6.  Saberete vsichki potrebiteli s client v imeto v tazi grupa.
echo "Zadacha 6." |& tee -a ${HW_OUTPUT}

# obikaliame potrebitelite
for u in `getent passwd | cut -d: -f1 | grep -i ".*client.*"`
do
    # dobavqme vseki potrebitel kum Clients
    sudo usermod -aG Clients "$u" |& tee -a ${HW_OUTPUT}
done

getent group Clients |& tee -a ${HW_OUTPUT}

# 7.  Proverete dali tezi potrebiteli ne sa chlenove na druga grupa.
echo "Zadacha 7." |& tee -a ${HW_OUTPUT}

# obikaliame potrebitelite
for u in `getent passwd | cut -d: -f1 | grep -i ".*client.*"`
do
    # pokazvame kam koi grupi prinadleji
    groups "$u" |& tee -a ${HW_OUTPUT}
done

# 8.  Namerete i saberete v direktoriya lost+found vsichki faylove i direktorii bez sobstvenik
#     i parvichna grupa na sobstvenik.
echo "Zadacha 8." |& tee -a ${HW_OUTPUT}
find -nouser -nogroup |& tee -a ${HW_OUTPUT}

# Za po qsno moje da izprintim user/group explicitno
find -nouser -nogroup | xargs stat --format "%n: user: %u (%U), group: %g (%G)" |& tee -a ${HW_OUTPUT}

# da gi suberem
mkdir -p "lost+found" |& tee -a ${HW_OUTPUT}

# polzvame -t, za da slojim "target" direktoriata predi source-a i taka mojem da polzvame xargs
# polzvame --parents za da zapazim patq na file-ovete
find -nouser -nogroup | xargs cp --parents -t "lost+found" |& tee -a ${HW_OUTPUT}

# 9.  Otkriyte vsichki protsesi s nomer 48 kato roditelski ili kato sobstven protses.
echo "Zadacha 9." |& tee -a ${HW_OUTPUT}
ps --ppid=48 --pid=48 |& tee -a ${HW_OUTPUT}

# za da go testvam, shte probvam s otvoren vim
ps --ppid=`pidof vim` --pid=`pidof vim` |& tee -a ${HW_OUTPUT}

# 10. Sotirayte gi po nomer na roditelski protses.
echo "Zadacha 10." |& tee -a ${HW_OUTPUT}
ps --ppid=48 --pid=48 --sort=ppid |& tee -a ${HW_OUTPUT}

# za da go testvam, shte probvam s otvoren vim
ps --ppid=`pidof vim` --pid=`pidof vim` --sort=ppid |& tee -a ${HW_OUTPUT}

# 11. Pokazhete parametrite na sredata im.
echo "Zadacha 11." |& tee -a ${HW_OUTPUT}

# shte vzemem spisuk samo s PID na processite (bez header)
# i shte izprintim informaciata za tqh ot procfs
for p in `ps -e -o pid=`
do
    echo "Process $p (`cat /proc/$p/comm`)" |& tee -a ${HW_OUTPUT}
    echo "environment: `cat /proc/$p/environ`" |& tee -a ${HW_OUTPUT}
done

# 12. Smenete na vsichki redaktora po podrazbirane na vi.
echo "Zadacha 12." |& tee -a ${HW_OUTPUT}

# Neka vidim configuraciata
update-alternatives --list editor |& tee -a ${HW_OUTPUT}

# Da izberem vim (vim.basic) za redaktor po podrazbirane
sudo update-alternatives --set editor /usr/bin/vim.basic |& tee -a ${HW_OUTPUT}

# 13. Prebroyte kolko fayla ima v direktoriya /home.
echo "Zadacha 13." |& tee -a ${HW_OUTPUT}
find /home -type f | wc -l |& tee -a ${HW_OUTPUT}

# A kolko poddirektorii ima?
find /home -type d | wc -l |& tee -a ${HW_OUTPUT}

# A kolko ot tezi poddirektorii zapochvat s dve tochki?
find /home -type d -name "..*" | wc -l |& tee -a ${HW_OUTPUT}

# A kolko ot tezi direktorii zapochvat samo s edna tochka?
find /home -type d -name ".*" | wc -l |& tee -a ${HW_OUTPUT}

# zachistvame napravenite vremenni promeni po sredata
cleanup
