CREATE SCHEMA trabalho_bd;
use trabalho_bd;

CREATE TABLE Academia (
    CNPJ varchar(15) NOt NULL,
    CEP varchar(15) NOT NULL,
    UF varchar(2) NOT NULL,
    Cidade varchar(55) NOT NULL,
    Nome varchar (40)NOt NULL,
	Telefone varchar (20)NOt NULL,
    Twitter varchar(55) DEFAULT NULL,
    Facebook varchar(55) DEFAULT NULL,
    Instagram varchar(55) DEFAULT NULL,
    Email  varchar (55) DEFAULT NULL,
    Rua varchar(55) NOT NULL,
    Bairro varchar(55) NOT NULL,
    Logradouro varchar(55) NOT NULL,
	PRIMARY KEY (CNPJ,CEP)
);

CREATE TABLE Telefone_Academia(
	Telefone varchar(20) NOT NULL,
    CNPJ_Academia varchar(15) NOt NULL,
    CEP_Academia varchar(15) NOT NULL,
    primary key(Telefone,CNPJ_Academia,CEP_Academia),
    foreign key(CNPJ_Academia,CEP_Academia) references Academia(CNPJ,CEP)
);



CREATE TABLE Funcionario(
	CPF varchar(15)  NOT NULL,
    Nome  varchar(40) NOT NULL,
    DataDeNascimento date  default NULL,
    Salario  decimal(10,2) NOT NULL,
    Sexo char(1) NOT NULL,
    FormaDeContrato varchar(40) NOT NULL,
    Email  varchar(45) NOT NULL,
    Telefone  varchar(15) NOT NULL,
    Rua varchar(55) NOT NULL,
    Bairro varchar(55) NOT NULL,
    Numero varchar(5) NOT NULL,
	PRIMARY KEY (CPF)
);


CREATE TABLE Contrata_Funcionario (
    CNPJ_Academia varchar(15)  NOt NULL,
    CEP_Academia varchar(15) NOT NULL,
	CPF_Funcionario varchar(15)  NOT NULL,
	PRIMARY KEY (CNPJ_Academia, CPF_Funcionario),
	FOREIGN KEY (CNPJ_Academia) REFERENCES Academia(CNPJ),
	FOREIGN KEY (CPF_Funcionario) REFERENCES Funcionario(CPF)
);

CREATE TABLE Contador(
	CRC varchar(15) NOT NULL,
	Foreign key (CRC) references Funcionario(CPF)
);

CREATE TABLE Instrutor (
	NumInstrutor varchar(15) NOT NULL,
    Foreign key (NumInstrutor) references Funcionario(CPF)
);
CREATE TABLE GerenteLogistica (
	NumGerenteLogistica varchar(15)  NOT NULL,
    Foreign key (NumGerenteLogistica) references Funcionario(CPF)
);
CREATE TABLE Secretario (
	NumSecretario varchar(15) NOT NULL,
    Foreign key (NumSecretario) references Funcionario(CPF)

);


CREATE TABLE AvaliadorFisico(
	CREF varchar(15)  NOT NULL,
	Foreign key (CREF) references Funcionario(CPF)
);



CREATE TABLE  Nutricionista (
	CRN varchar(15)  NOT NULL,
	Foreign key (CRN) references Funcionario(CPF)
    );



#CLIENTE 
CREATE TABLE Cliente (
	CPF varchar(15) NOT NULL,
	Nome  varchar(40) NOT NULL,
    Cli_NumSecretario  varchar(15)  NOT NULL,
	Email  varchar(45) NOT NULL,
    Telefone  varchar(15) NOT NULL,
	Bairro varchar (55) NOT NULL,
    Rua varchar(55) not null,
    Numero int not null,
	PRIMARY KEY (CPF),
    FOREIGN KEY (Cli_NumSecretario) REFERENCES Secretario(NumSecretario)
);



CREATE TABLE Matricula_Cliente_Secretario (
	Codigo int NOT NULL,
    Plano varchar(10) NOT NULL,
    DataInicio  date  default NULL,
    Modalidade varchar(15) NOT NULL,
	CPF_Cliente varchar(15)  NOT NULL,
    PRIMARY KEY (Codigo),
    FOREIGN KEY (CPF_Cliente) REFERENCES Cliente(CPF)
);

#



# Relacionamento Avalia 

CREATE TABLE IMC_Avalia(
	Peso  FLOAt  NOT NULL,
    Altura FLOAt NOT NULL,
	IMC float  NOt NULL,
    PRIMARY KEY (IMC)
);

CREATE TABLE Avalia_Cliente(
	Codigo int  NOT NULL,
	CPF_Cliente varchar(15)  NOT NULL,
    CREF_Avaliador varchar(15)  NOT NULL,
	CRN_Nutricionista varchar(15)  NOT NULL,
    Torax FLOAT NOT NULL,
    Cintura FLOAT NOT NULL,
    Abdomen Float NOT NULL,
    PesoMagro FLOAT NOT NULL,
    PesoGordo Float NOT NULL,
    IMC_Calculado float not null,
	PRIMARY KEY (Codigo),
    FOREIGN KEY (CPF_Cliente) REFERENCES Cliente(CPF),
    FOREIGN KEY (CREF_Avaliador) REFERENCES AvaliadorFisico (CREF),
	FOREIGN KEY (CRN_Nutricionista ) REFERENCES  Nutricionista (CRN),
    FOREIGN KEY(IMC_Calculado) references IMC_Avalia(IMC)
);


CREATE TABLE FichaTreino(
	Codigo int  NOt NULL,
	TempoEntreSerie  int  NOT NULL,  
    Exercicios text(300) NOT NULL ,
    NumerodeRepeticao int  NOT NULL,
    DataInicio  date  default NULL,
    TipoDeSerie varchar(10) NOT NULL,
    PRIMARY KEY (Codigo)
);

CREATE TABLE FichaNutricional(
	Codigo int  NOt NULL,
	Diagnostico  text(400) NOT NULL, # verificar como o tipo de dados 
	DataDiagnostico  date  default NULL,
    CafeDaManha text(400) NOT NULL,
	Lanche text(400)  NOT NULL,
    Almoco  text(400)  NOT NULL,
    Janta   text(400)  NOT NULL,
    PRIMARY KEY (Codigo)
);

CREATE TABLE Prescreve_Treino(
	Codigo_Avalia int  NOt NULL,
	Codigo_Treino int   NOt NULL,
	Data_Prescricao  date  default NULL,
    PRIMARY KEY (Codigo_avalia, Codigo_Treino ),
	FOREIGN KEY ( Codigo_avalia) REFERENCES Avalia_Cliente (Codigo),
	FOREIGN KEY ( Codigo_Treino) REFERENCES FichaTreino (Codigo)
);

CREATE TABLE Prescreve_FichaNutricional(
	Codigo_Avalia int  NOt NULL,
	Codigo_FichaNutricional int   NOt NULL,
	Data_Prescricao  date  default NULL,
    PRIMARY KEY (Codigo_avalia,Codigo_FichaNutricional),
	FOREIGN KEY ( Codigo_avalia) REFERENCES Avalia_Cliente (Codigo),
	FOREIGN KEY ( Codigo_FichaNutricional) REFERENCES FichaNutricional(Codigo)
);






# Relacionamento faz balanceamneto 

CREATE TABLE Faz_BalancoPatrimonial (
	Codigo int  NOt NULL,
	DataBalanco date  NOT NULL,
	CNPJ_Academia varchar(15)  NOt NULL,
    CEP_Academia varchar(15) NOT NULL,
	CRC_Contador varchar(15)  NOT NULL,
    Caixa FLOAT   NOT NULL,
    DuplicatasAReceber FLOAT   NOT NULL,
    Estoque FLOAT  NOt NULL,
    TotalAtivoCirculante FLOAT  NOT NULL,
	Salario  float NOT NULL,
	Impostos float  NOT NULL,
	Adiantamentos  float   NOT NULL,
	Fornecedores  float   NOT NULL,
	TotalPassivoCirculante float NOt NULL,
    ContasAReceber  float   NOT NULL,
    Imobilizado  float   NOT NULL,
    Intangivel float NOT NULL,
    Investimentos float NOT NULL,
    TotalAtivoNaoCirculante float NOT NULL,
	CapitalSocial float  NOT NULL,
	ReservaDeLucros  float   NOT NULL,
	ReservaDeCapital float   NOT NULL,
    TotalPatrimonioLiquido float NOt NULL,
    PRIMARY KEY (Codigo),
	FOREIGN KEY (CNPJ_Academia,CEP_Academia) REFERENCES Academia (CNPJ,CEP),
	FOREIGN KEY (CRC_Contador) REFERENCES Contador (CRC)
);



# relacionamento afz demonstraçao de redemineto contabeis 
CREATE TABLE Faz_DRE(
	Codigo  int NOt NULL,
    Data_DRE  date  default NULL,
    ReceitaLiquida float not null,
    LucroOperacional float not null,
    LucroLiquido float not null,
    CNPJ_Academia varchar(15)  NOt NULL,
    CEP_Academia varchar(15) NOT NULL,
    CRC_Contador  varchar(15) NOT NULL,
    PRIMARY KEY (Codigo),
    FOREIGN KEY(CNPJ_Academia,CEP_Academia) references Academia(CNPJ,CEP),
    FOREIGN KEY(CRC_Contador) references Contador(CRC)
);





CREATE TABLE Equipamentos(
	Codigo int NOT NULL,
    Garantia date NOT NULL,
    Modelo varchar(55) NOT NULL,
    Comprimento int default null,
    Altura int default null,
    Largura int default null,
    Estrutura varchar(55),
    Primary Key(Codigo)
);

CREATE TABLE Compra(
	Codigo int  NOT NULL,
	Codigo_Solicita int  DEFAULT NULL,
	Codigo_Equipamentos int DEFAULT null,
	Codigo_Autoriza int DEFAULT  NULL,
	DataDeCompra date not  NULL,
	Contrato  varchar(20)  NOT NULL,
	NotaFiscal varchar(20)  NOT NULL,
	PRIMARY KEY(Codigo),
	#FOREIGN KEY ( Codigo_Solicita) REFERENCES Solicita (Codigo),
	#FOREIGN KEY ( Codigo_Autoriza) REFERENCES Autoriza (Codigo),
	FOREIGN KEY (Codigo_Equipamentos) REFERENCES Equipamentos (Codigo)
);


CREATE TABLE Autoriza(
	 DatadeAutorizacao date  not  NULL,
     CRC_Contador varchar(15) NOT NULL,
	 Codigo_Compra int  not  NULL,
     Autorizacao text(400)  NOT NULL,
     PRIMARY KEY (CRC_Contador, Codigo_Compra),
	 FOREIGN KEY (CRC_Contador) REFERENCES Contador (CRC)
);

CREATE TABLE Solicita(
	Codigo_Compra int  NOT NULL,
    Sol_NumGerenteLogistica varchar(15) NOT NULL,
	DataDeSolicitacao date  not  NULL,
	Requerimento text(600)  NOT NULL,
	Foreign Key (Codigo_Compra) references Compra(Codigo),
    Foreign Key (Sol_NumGerenteLogistica) references GerenteLogistica(NumGerenteLogistica)
);



CREATE TABLE Tem_Academia_Equipamentos(
	CNPJ_Academia varchar(15) NOt NULL,
    CEP_Academia varchar(15) NOT NULL,
    Codigo_Equipamentos int NOT NULL,
    Primary Key(CNPJ_Academia,CEP_Academia,Codigo_Equipamentos),
    FOREIGN KEY(CNPJ_Academia,CEP_Academia) references Academia(CNPJ,CEP),
    Foreign Key(Codigo_Equipamentos) references Equipamentos(Codigo)
);

#Solicita e Autoriza referenciam compra. Mas compra também referencia essas 2?




CREATE TABLE Terceirizada(
	Codigo int NOT NULL,
    Nome varchar(55) NOT NULL,
    Telefone varchar(15) NOT NULL,
    Email varchar(55) NOT NULL,
    Primary Key(Codigo)
);

CREATE TABLE Manutencao(
	Codigo_Manutencao int NOT NULL,
    Codigo_Equipamentos int NOT NULL,
    Codigo_Terceirizada int NOT NULL,
    Data_Manutencao date NOT NULL,
    TempoInicioServico time NOT NULL,
    TempoTerminoServico time NOT NULL,
    NomeDoFuncionario varchar(55) NOT NULL,
    Primary Key(Codigo_Manutencao,Codigo_Equipamentos,Codigo_Terceirizada),
    Foreign Key(Codigo_Equipamentos) references Equipamentos(Codigo),
	Foreign Key(Codigo_Terceirizada) references Terceirizada(Codigo)

);

CREATE TABLE Vendidos(
	Codigo_Equipamentos int NOT NULL,
    Codigo_Terceirizada int NOT NULL,
    Data_Vendidos date NOT NULL,
    Primary Key(Codigo_Equipamentos,Codigo_Terceirizada),
    Foreign Key(Codigo_Equipamentos) references Equipamentos(Codigo),
    Foreign Key(Codigo_Terceirizada) references Terceirizada(Codigo)

);



Alter table Autoriza
add FOREIGN KEY (Codigo_Compra) references Compra(Codigo);




