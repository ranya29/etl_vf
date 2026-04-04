USE MIC_DWH;
GO

--DIMENSIONS
--dim_client
CREATE TABLE dbo.dim_client (
    client_key INT IDENTITY(1,1) PRIMARY KEY,
    reference_client NVARCHAR(50),
    nom_client NVARCHAR(100)
);

--dim_commande
CREATE TABLE dbo.dim_commande (
    commande_key INT IDENTITY(1,1) PRIMARY KEY,

    reference_commande NVARCHAR(50),
    reference_client NVARCHAR(50),

    qte_planifiee_source DECIMAL(18,3) NULL, -- gardée mais non alimentée

    lavage NVARCHAR(50),
    modele NVARCHAR(100),
    designation_tissu NVARCHAR(100),
    designation_faconnier NVARCHAR(100),
    nom_client_source NVARCHAR(100),

    ligne_soldee BIT,

    saison NVARCHAR(50),
    date_export_prevue DATE,
    date_export DATE,
    code_standard NVARCHAR(50),
    semaine_export_prevue INT,
    semaine_export INT
);

--dim_jalon
CREATE TABLE dbo.dim_jalon (
    jalon_key INT IDENTITY(1,1) PRIMARY KEY,
    code_jalon INT,
    nom_jalon NVARCHAR(100)
);


--dim_date
CREATE TABLE dbo.dim_date (
    date_key INT PRIMARY KEY,
    date_complete DATE,
    annee INT,
    mois INT,
    jour INT,
    semaine INT,
    trimestre INT,
);

--dim_atelier
CREATE TABLE dbo.dim_atelier (
    atelier_key INT IDENTITY(1,1) PRIMARY KEY,
    nom_atelier NVARCHAR(100)
);

--dim_saison
CREATE TABLE dbo.dim_saison (
    saison_key INT IDENTITY(1,1) PRIMARY KEY,

    code_saison NVARCHAR(20),      
    annee_saison NVARCHAR(10),     
    type_saison NVARCHAR(20)       
);

--dim_operateur
CREATE TABLE dbo.dim_operateur (
    operateur_key INT IDENTITY(1,1) PRIMARY KEY,
    matricule NVARCHAR(50)
);

--dim_defaut
CREATE TABLE dbo.dim_defaut (
    defaut_key INT IDENTITY(1,1) PRIMARY KEY,
    nom_defaut NVARCHAR(100),
    categorie_defaut NVARCHAR(100),
    atelier NVARCHAR(100),
    type_ligne_vente NVARCHAR(50)
);

--dim_mouvement
USE MIC_DWH;
GO

CREATE TABLE dbo.dim_mouvement (
    mouvement_key INT IDENTITY(1,1) PRIMARY KEY,

    date_comptabilisation DATETIME2,

    reference_client NVARCHAR(50),
    reference_commande NVARCHAR(50),

    code_jalon INT,

    qte_entree DECIMAL(18,3),
    qte_sortie DECIMAL(18,3),
    qte_encours DECIMAL(18,3),

    sortie_vers_venue_de NVARCHAR(50),

    type_mouvement NVARCHAR(50)
);

--FACT TABLES
--fact_stock_jalon_commande
CREATE TABLE dbo.fact_stock_jalon_commande (
    stock_jalon_key INT IDENTITY(1,1) PRIMARY KEY,

    commande_key INT,
    client_key INT,
    jalon_key INT,
    date_key INT,

    qte_entree_totale_jalon DECIMAL(18,3),
    qte_sortie_totale_jalon DECIMAL(18,3),
    reste_jalon DECIMAL(18,3),

    nb_mouvements_jalon INT,
    duree_jalon_heures FLOAT
);

--fact_suivi_commandes
CREATE TABLE dbo.fact_suivi_commandes (
    suivi_key INT IDENTITY(1,1) PRIMARY KEY,

    date_key INT,
    commande_key INT,
    client_key INT,
    jalon_courant_key INT,

    qte_planifiee_source DECIMAL(18,3) NULL, -- gardée mais non remplie
    qte_reception DECIMAL(18,3),
    qte_defaut DECIMAL(18,3),

    reste_a_traiter DECIMAL(18,3),

    nb_mouvements INT,
    nb_jalons_parcourus INT,

    taux_realisation FLOAT,
    taux_defaut_sur_planifie FLOAT,

    duree_cycle_jours INT
);

--fact_reception
CREATE TABLE dbo.fact_reception (
    reception_key INT IDENTITY(1,1) PRIMARY KEY,
    client_key INT,
    date_key INT,

    qte_reception DECIMAL(18,3),
    nb_receptions INT
);

--fact_defauts
CREATE TABLE dbo.fact_defauts (
    defaut_fact_key INT IDENTITY(1,1) PRIMARY KEY,

    client_key INT,
    date_key INT,
    defaut_key INT,
    atelier_key INT,

    qte_defaut DECIMAL(18,3)
);