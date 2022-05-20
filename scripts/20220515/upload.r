libary(GwasDataImport)

download.file("https://pheweb.jp/download/Smoking_CPD", "Smoking_CPG.gz")

x <- Dataset$new(filename="Smoking_CPD.gz")
x$collect_metadata(list(
	ontology="EFO:0006525",
	trait="Cigarettes per day",
	population = "East Asian",
	sex="Males and Females",
	pmid="31089300",
	author="Matoba N",
	consortium="Biobank Japan",
	sample_size=72655,
	year=2019,
	build="HG19/GRCh37",
	unit="Cigarettes per day",
	group_name = "public",
	category="Risk factor",
	subcategory="NA"
))
x$api_metadata_upload()
x$determine_columns(list(
	snp_col=2,
	chr_col=3,
	pos_col=4,
	ea_col=5,
	oa_col=6,
	eaf_col=7,
	beta_col=11,
	se_col=12,
	pval_col=14,
	imp_info_col=9
))
x$format_data()
x$api_gwasdata_upload()
saveRDS(x, file="obj.rds")
