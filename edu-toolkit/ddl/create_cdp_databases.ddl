CREATE DATABASE scm DEFAULT CHARACTER SET utf8;
GRANT ALL on scm.* TO 'scm'@'%' IDENTIFIED BY 'BadPass@1';
GRANT ALL on scm.* TO 'scm'@'localhost' IDENTIFIED BY 'BadPass@1';
CREATE DATABASE amon DEFAULT CHARACTER SET utf8;
GRANT ALL on amon.* TO 'amon'@'%' IDENTIFIED BY 'BadPass@1';
CREATE DATABASE rman DEFAULT CHARACTER SET utf8;
GRANT ALL on rman.* TO 'rman'@'%' IDENTIFIED BY 'BadPass@1';
CREATE DATABASE metastore DEFAULT CHARACTER SET utf8;
GRANT ALL on metastore.* TO 'hive'@'%' IDENTIFIED BY 'BadPass@1';
CREATE DATABASE oozie DEFAULT CHARACTER SET utf8;
GRANT ALL on oozie.* TO 'oozie'@'%' IDENTIFIED BY 'BadPass@1';
CREATE DATABASE hue DEFAULT CHARACTER SET utf8;
GRANT ALL on hue.* TO 'hue'@'%' IDENTIFIED BY 'BadPass@1';
CREATE DATABASE ranger DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
GRANT ALL ON ranger.* TO 'rangeradmin'@'%' IDENTIFIED BY 'BadPass@1';
CREATE DATABASE rangerkms DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
GRANT ALL ON rangerkms.* TO 'rangerkms'@'%' IDENTIFIED BY 'BadPass@1';
CREATE DATABASE smm DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
GRANT ALL ON smm.* TO 'smm'@'%' IDENTIFIED BY 'BadPass@1';
CREATE DATABASE schemaregistry DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
GRANT ALL ON schemaregistry.* TO 'schemaregistry'@'%' IDENTIFIED BY 'BadPass@1';
FLUSH PRIVILEGES;
