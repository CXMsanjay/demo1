class mysql::data {
	$my_env = [ 'd1', 'd2', 'd3', 'd4', 'd8' , 'd9' ]

	each($my_env) |$value| {
	file { "/${value}.csv":
		source => "puppet:///modules/mysql/${value}.csv",
		ensure => present,
	} ->

	exec { "${value}":
		
		command => "/usr/bin/mysql -uroot -predhat -D demo -e 'create table $value(id int, name varchar(12));'",
		unless => "/usr/bin/mysql -u root -predhat -D demo -e 'show tables;' | grep $value",
	} ->

	exec { "${value}_table":
		command => "/usr/bin/mysql -uroot -predhat -D demo -e 'load data local infile \"/$value.csv\" into table $value fields terminated by \",\" lines terminated by \"\n\" '" ,
		unless => "/usr/bin/mysql -u root -predhat -D demo -e 'select * from $value;' | grep id",
		
	}
	}

}
