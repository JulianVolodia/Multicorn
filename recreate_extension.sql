drop extension multicorn cascade;
create extension multicorn;
create server multicorn_srv foreign data wrapper multicorn;

drop foreign table csvtest;
create foreign table csvtest (
       year numeric,
       make character varying,
       model character varying
) server multicorn_srv options (
       wrapper 'multicorn.csvfdw.CsvFdw',
       filename '/tmp/test.csv',
       skip_header '1',
       delimiter ',');
select * from csvtest;
select * from csvtest where field1 = 1;
select * from csvtest where field2 = 'test';

create foreign table ldaptest (
       cn character varying,
       sn character varying,
       uid character varying,
       "uidNumber" int,
       o character varying,
       mail character varying
) server multicorn_srv options (
       wrapper 'multicorn.ldapfdw.LdapFdw',
       address 'ldap.keleos.fr',
       "path" 'ou=People,dc=keleos,dc=fr',
       objectclass 'inetOrgPerson');
select * from ldaptest;
select * from ldaptest where uid = 'gayoub';
select * from ldaptest where "uidNumber" = 1022;
select * from ldaptest where cn like '%y%';

create foreign table fstest (
       field1 character varying collate "fr_FR.utf8",
       field2 character varying collate "fr_FR.utf8",
       field3 character varying collate "fr_FR.utf8"
) server multicorn_srv options (
       wrapper 'multicorn.fsfdw.FilesystemFdw',
       root_dir '/tmp/data',
       content_column 'content'

       pattern '{field1}/{field2}/{field3}/style.css');
    DROP FOREIGN TABLE musicfilesystem;
    CREATE FOREIGN TABLE musicfilesystem (
        artist  character varying,
        album   character varying,
        track   integer,
        title   character varying,
        content bytea,
        filename character varying
    ) server multicorn_srv options(
        wrapper     'multicorn.fsfdw.FilesystemFdw',
        root_dir    '/tmp/base_dir',
        pattern     '{artist}/{album}/{track} - {title}.ogg',
        content_column  'contentaa',
        filename_column 'filename');


select * from musicfilesystem;

select * from fstest where field2 = 'test';

create foreign table sqlitetest (
       field1 character varying,
       field2 int,
       field3 numeric
) server multicorn_srv options (
       wrapper 'multicorn.sqlitefdw.SqliteFdw',
       filename '/tmp/test.sqlite3',
       tablename 'test');
select * from sqlitetest;
select * from sqlitetest where field1 = 'test';

create foreign table proctest (
       process_name character varying,
       pid character varying
 ) server multicorn_srv options (
       wrapper 'multicorn.processfdw.ProcessFdw');
select * from proctest;

create foreign table statetest (
       state integer
) server multicorn_srv options (
       wrapper 'multicorn.statefdw.StateFdw');
select state from statetest;
select state from statetest;
select state from statetest;
select state from statetest;

create foreign table rsstest (
    title character varying,
    link character varying,
    "pubDate" timestamp
) server multicorn_srv options (
       wrapper 'multicorn.rssfdw.RssFdw',
       url 'http://www.reddit.com/.rss'
);

select * from rsstest;

create foreign table gittest (
       author_name character varying,
       author_email character varying,
       message character varying,
       "date" date,
       hash character varying
) server multicorn_srv options (
       wrapper 'multicorn.gitfdw.GitFdw',
       "path" '/tmp/multicorn' );
select * from gittest;

create foreign table googletest (
       url character varying,
       title character varying,
       "search" character varying
) server multicorn_srv options (
       wrapper 'multicorn.googlefdw.GoogleFdw');
select * from googletest where "search" = 'multicorn';

create foreign table enterprisetest(
    phone character varying,
    postcode character varying
) server multicorn_srv options (
       filename '/tmp/extraction_101018.xls',
       wrapper 'enterpriseMulticorn.EnterpriseMulticorn');
select * from googletest where "search" = 'multicorn';

