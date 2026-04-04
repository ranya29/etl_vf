USE MIC_Staging;
GO
--stg_transfert
CREATE TABLE dbo.stg_transfert (
    id INT IDENTITY(1,1) PRIMARY KEY,

    source_timestamp DATETIME2,
    document_type NVARCHAR(50),
    document_no NVARCHAR(50),
    bl_origine NVARCHAR(50),

    date_comptabilisation DATETIME2,
    date_creation DATETIME2,

    reference_client NVARCHAR(50),
    reference_commande NVARCHAR(50),

    avancement INT,

    qte_entree DECIMAL(18,3),
    qte_sortie DECIMAL(18,3),
    qte_encours DECIMAL(18,3),

    sortie_vers_venue_de NVARCHAR(50),
    mouvement_manuel BIT,
    utilisateur NVARCHAR(50),

    stg_load_date DATETIME2 DEFAULT GETDATE()
);

--stg_jalons
CREATE TABLE dbo.stg_jalons (
    code_jalon INT,
    nom_jalon NVARCHAR(100),

    stg_load_date DATETIME2 DEFAULT GETDATE()
);

--stg_wic_info
CREATE TABLE dbo.stg_wic_info (
    id INT IDENTITY(1,1) PRIMARY KEY,

    reference_commande NVARCHAR(50),
    reference_client NVARCHAR(50),

    qte_planifiee DECIMAL(18,3),

    lavage NVARCHAR(50),
    modele NVARCHAR(100),
    designation_tissu NVARCHAR(100),
    designation_faconnier NVARCHAR(100),
    nom_client_wic NVARCHAR(100),

    ligne_soldee BIT,

    saison NVARCHAR(50),
    date_export_prevue DATE,
    date_export DATE,

    code_standard NVARCHAR(50),
    semaine_export_prevue INT,
    semaine_export INT,

    stg_load_date DATETIME2 DEFAULT GETDATE()
);

--stg_quality
CREATE TABLE dbo.stg_quality (
    id INT IDENTITY(1,1) PRIMARY KEY,

    date_lecture DATETIME2,
    reference_client NVARCHAR(50),

    atelier NVARCHAR(100),
    defaut NVARCHAR(100),
    categorie_defaut NVARCHAR(100),
    type_ligne_vente NVARCHAR(50),

    qte_defaut DECIMAL(18,3),

    stg_load_date DATETIME2 DEFAULT GETDATE()
);

--stg_recep_805
CREATE TABLE dbo.stg_recep_805 (
    id INT IDENTITY(1,1) PRIMARY KEY,

    date_scan DATETIME2,
    reference_client NVARCHAR(50),

    matricule NVARCHAR(50),
    qte_reception DECIMAL(18,3),

    stg_load_date DATETIME2 DEFAULT GETDATE()
);