class mysql::data {
	file { '/newdata.csv':
		source => "puppet:///modules/mysql/file.csv",
		ensure => present,
	}


	exec { "command4":
		command => '/usr/bin/mysql -uroot -predhat -D demo -e "create table first(id int, name varchar(12));"',
		unless => '/usr/bin/mysql -u root -predhat -D demo -e "show tables;" | grep first',
	}->


	exec { "renew1":
		command => '/usr/bin/mysql -uroot -predhat -D demo -e "load data local infile \'/newdata.csv\' into table first fields terminated by \',\' lines terminated by \'\n\' (id,name)";',

	}
}
