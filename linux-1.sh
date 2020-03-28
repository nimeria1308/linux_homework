# ime
echo "Ime: Simona Dimitrova"

# fakulteten nomer
echo "Fakulteten nomer: f97074"

# data vav format chas:min:sek:mesec:den:godina
date +"%H:%M:%S:%m:%d:%y"

# tekushta direktoria
pwd

# sadarjanie na tekushta direktoria: izpulnimite fileove imat * sled imeto
ls -F

# dospa do .profile vav home direktoriata
ls -l ~/.profile

# suzdavame primeren file v home direktoriata
# slagame mu dostap rwxrwxrwx (0777)
# printim dostapa, za da potvurdim che naistina e taka
touch ~/test_access
chmod 0777 ~/test_access
ls -l ~/test_access

# vrashtame originalnata nastroika (rw-r--r--)
# mahame execuatable za vsichki
# mahame write prava za group i other
chmod -x,g-w,o-w ~/test_access
ls -l ~/test_access
