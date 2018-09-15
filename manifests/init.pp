class mysql {
	package { ["mysql-server"]:
		ensure => present,
	}->
	
	service { "mysqld":
		ensure => running,
		enable => "true" ,
	}->

	exec { "command2":
		command => '/usr/bin/mysqladmin password "redhat"',
		unless => '/usr/bin/mysql -u root -predhat -e "select password from mysql.user WHERE User=\'root\'"',
	}->
	
	exec { "command1":
		command => '/usr/bin/mysql -uroot -predhat -e "DELETE FROM mysql.user WHERE User=" " ;" ; /usr/bin/mysql -uroot -predhat -e "DELETE FROM mysql.user WHERE User="root" AND Host NOT IN ("localhost", "127.0.0.1", "::1");" ; /usr/bin/mysql -uroot -predhat -e "DROP DATABASE test;" ; /usr/bin/mysql -uroot -predhat -e "DELETE FROM mysql.db WHERE Db="test" OR Db="test\_%";" ; /usr/bin/mysql -uroot -predhat -e "FLUSH PRIVILEGES;"',
	}->

	exec { "command3":
		command => '/usr/bin/mysql -uroot -predhat -e "create database demo"',
		unless => '/usr/bin/mysql -u root -predhat -e "show databases;" | grep demo',
	}


	#exec { "command5":
	#	command => '/usr/bin/mysqldump -uroot -predhat demo > /mysqlbackup',
	#	unless => '/bin/ls / | grep mysqlbackup',
	#}
}
