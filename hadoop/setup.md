Убедитесь, что у Linux VM, созданной в предыдущем ДЗ, не менее 16 GB RAM, 50 GB HDD и ОС Ubuntu не выше версии 20.

Запустите VM.

На своём компьютере добавить в файл /etc/hosts публичный IP-адрес VM под именем sandbox-hdp.hortonworks.com.
Пример:
51.250.22.171 sandbox-hdp.hortonworks.com
Запустите Hortonworks HDP Sandbox (https://hub.docker.com/r/hortonworks/sandbox-hdp) в Docker:
docker run -it --rm --hostname=sandbox-hdp.hortonworks.com --privileged=true -p 2222:22 -p 8080:8080 -p 1080:1080 -p 21000:21000 -p 6080:6080 -p 50070:50070 -p 9995:9995 -p 30800:30800 -p 4200:4200 -p 8088:8088 -p 19888:19888 -p 16010:16010 -p 11000:11000 -p 8744:8744 -p 8886:8886 -p 18081:18081 -p 8443:8443 -p 10000:10000 hortonworks/sandbox-hdp:3.0.1

Появится приглашение «login:». Ввести «root» в качестве имени и «hadoop» в качестве пароля.

Появится приглашение сменить пароль пользователя root. Ввести старый пароль «hadoop», придумать и ввести новый пароль. Ввести новый пароль ещё раз для подтверждения.

Выполнить команду «ambari-server status» для проверки того, что Ambari запущен. В выводе команды должно присутствовать «Ambari Server running».

Выполнить команду «ambari-admin-password-reset», придумать и ввести пароль пользователя admin.

Открыть в браузере своего компьютера страницу http://sandbox-hdp.hortonworks.com:8080. Имя пользователя: «admin», пароль — пароль, придуманный на шаге 8.

Проверить и запустить службы HDFS, YARN, Hive, Spark2, Zeppelin Notebook и Data Analytics Studio. Сделать снимок экрана и приложить его к ДЗ для демонстрации выполненного задания.

(*) Опционально выполнить инструкции из https://github.com/hayari/data-tutorials/tree/master/tutorials/hdp/tag-based-policies-with-apache-ranger-and-apache-atlas.

Дополнительная информация о «песочнице»: https://github.com/hayari/data-tutorials/blob/master/tutorials/hdp/learning-the-ropes-of-the-hortonworks-sandbox/tutorial.md.