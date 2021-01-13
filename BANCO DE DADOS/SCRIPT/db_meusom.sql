create database db_meusom;
use db_meusom;

create table tb_uf(
cd_uf int not null auto_increment, 
sg_uf char(2),
nm_uf varchar(60),
	constraint pk_uf
		primary key(cd_uf)
);

create table tb_cidade(
cd_cidade int not null auto_increment, 
nm_cidade varchar(60),
cd_uf int, 
	constraint pk_cidade	
		primary key(cd_cidade),
	constraint fk_cidade_uf
		foreign key(cd_uf)
			references tb_uf(cd_uf)
);

create table tb_bairro(
cd_bairro int not null auto_increment, 
nm_bairro varchar(70),
cd_cidade int, 
	constraint pk_bairro
		primary key(cd_bairro),
	constraint fk_bairro_cidade
		foreign key(cd_cidade)
			references tb_cidade(cd_cidade)
);

create table tb_logradouro(
cd_logradouro int not null auto_increment, 
nm_logradouro varchar(100),
cd_cep varchar(20),
cd_bairro int, 
cd_casa varchar(10),
	constraint pk_logradouro
		primary key(cd_logradouro),
	constraint fk_logradouro_bairro
		foreign key(cd_bairro)
			references tb_bairro(cd_bairro)
);


create table tb_usuario(
cd_usuario int not null auto_increment,
nm_usuario varchar(200),
nm_email varchar(200),
nm_senha varchar(100),
ic_usuario boolean, 
cd_cpf varchar(13), 
cd_cnpj varchar(30),
im_perfil varchar(250),
im_capa varchar(250),
dt_nascimento date,
ic_ativo boolean,
cd_bairro int, 
	constraint pk_usuario	
		primary key(cd_usuario),
	constraint fk_usuario_bairro
		foreign key(cd_bairro)
			references tb_bairro(cd_bairro)
);

create table tb_anuncio(
cd_anuncio int not null auto_increment, 
cd_usuario int, 
cd_logradouro int,
hr_inicio time, 
hr_termino time, 
dt_anuncio date, 
nm_anuncio varchar(200),
ds_anuncio varchar(300),
im_capa_anuncio varchar(200),
cd_telefone_a varchar(15),
cd_celular_a varchar(15),
nm_email_a varchar(100),
	constraint pk_anuncio
		primary key(cd_anuncio),
	constraint fk_anuncio_logradouro
		foreign key(cd_logradouro)
			references tb_logradouro(cd_logradouro),
	constraint fk_anuncio_usuario
		foreign key(cd_usuario)
			references tb_usuario(cd_usuario)
);

create table tb_imagem(
cd_imagem int not null auto_increment,
im_anuncio varchar(100),
cd_anuncio int, 
	constraint pk_imagem
		primary key(cd_imagem),
	constraint fk_imagem_anuncio
		foreign key(cd_anuncio)
			references tb_anuncio(cd_anuncio)
);

create table tb_publicacao(
cd_publicacao int not null auto_increment,
cd_usuario int, 
im_publicacao varchar(2000),
ds_publicacao varchar(20000),
dt_publicacao date, 
hr_publicacao time,
	constraint pk_publicacao
		primary key(cd_publicacao),
	constraint fk_publicacao_usuario
		foreign key(cd_usuario)
			references tb_usuario(cd_usuario)
);

create table tb_curtida(
cd_curtida int not null auto_increment,
cd_usuario int, 
cd_publicacao int, 
	constraint pk_curtida
		primary key(cd_curtida),
	constraint fk_curtida_usuario
		foreign key(cd_usuario)
			references tb_usuario(cd_usuario),
	constraint fk_curtida_publicacao
		foreign key (cd_publicacao)
			references tb_publicacao(cd_publicacao)
);

create table tb_comentario(
cd_comentario int not null auto_increment,
cd_usuario int,
cd_publicacao int,
ds_comentario varchar(500),
dt_comentario date, 
hr_comentario time,
	constraint pk_comentario
		primary key(cd_comentario),
	constraint fk_comentario_usuario
		foreign key(cd_usuario)
			references tb_usuario(cd_usuario),
	constraint fk_comentario_publicacao
		foreign key(cd_publicacao)
			references tb_publicacao(cd_publicacao)
);

create table tb_notificacao(
cd_notif int not null auto_increment,
cd_usuario int, 
cd_publicacao int, 
nm_notif varchar(200),
ds_notif varchar(200),
dt_notif date, 
hr_notif time,
	constraint pk_notif
		primary key(cd_notif),
	constraint fk_notificacao_publicacao
		foreign key(cd_publicacao)
			references tb_publicacao(cd_publicacao)
);

create table tb_seguir(
cd_seguir int, 
cd_seguindo int, 
cd_usuario int, 
	constraint pk_seguir
		primary key(cd_seguir),
	constraint fk_seguir_usuario	
		foreign key(cd_usuario)
			references tb_usuario(cd_usuario)
);

create table tb_conversa(
cd_conversa int not null auto_increment, 
cd_usuario int, 
cd_receptor int,
	constraint pk_conversa
		primary key(cd_conversa),
	constraint fk_conversa_usuario
		foreign key(cd_usuario)
			references tb_usuario(cd_usuario)
);

create table tb_mensagem(
cd_mensagem int, 
cd_conversa int,
ds_mensagem int, 
hr_mensagem time, 
dt_mensagem date,
	constraint pk_mensagem
		primary key(cd_mensagem),
	constraint fk_mensagem_conversa
		foreign key(cd_conversa)
			references tb_conversa(cd_conversa)
);


create table tb_tipo_denuncia(
cd_tipo_denuncia int not null auto_increment,
nm_tipo_d varchar(100),
	constraint pk_tipo_denuncia	
		primary key(cd_tipo_denuncia)

);

create table tb_denuncia(
cd_denuncia int not null auto_increment,
ds_denuncia varchar(2000),
cd_tipo_denuncia int, 
cd_publicacao int, 
hr_denuncia time, 
dt_denuncia date, 
	constraint pk_denuncia
		primary key(cd_denuncia),
	constraint fk_denuncia_tipo	
		foreign key(cd_tipo_denuncia)
			references tb_tipo_denuncia(cd_tipo_denuncia),
	constraint fk_denuncia_publicacao
		foreign key(cd_publicacao)
			references tb_publicacao(cd_publicacao)
);

create table tb_audio(
cd_audio int not null auto_increment,
im_audio varchar(2000),
cd_publicacao int,
	constraint pk_audio
		primary key(cd_audio)
);

create table tb_video(
cd_video int not null auto_increment,
im_video varchar(2000),
cd_publicacao int, 
nm_video varchar(200),
	constraint pk_video
		primary key(cd_video)
);

create table tb_story(
cd_story int not null auto_increment,
cd_usuario int,
hr_story time,
dt_story date, 
im_story varchar(300), 
im_video_story varchar(200),
	constraint pk_story	
		primary key(cd_story),
	constraint fk_story_usuario
		foreign key(cd_usuario)
			references tb_usuario(cd_usuario)
);



