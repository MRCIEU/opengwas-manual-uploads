library(GwasDataImport)
library(data.table)
l <- list()

x <- Dataset$new(filename="EAGLE_European_Summary_Data_2022.tsv")
x$collect_metadata(list(
	ontology="EFO:0000274",
	trait="Atopic dermatitis",
	population = "European",
	sex="Males and Females",
	author="Budu-Aggrey A",
	consortium="EAGLE",
	ncase=60653,
    ncontrol=804329,
    sample_size=804329+60653,
	year=2022,
	build="HG19/GRCh37",
	unit="logOR",
	group_name = "public",
	category="Disease",
	subcategory="NA"
))
x$api_metadata_upload()
x$determine_columns(list(
	snp_col=1,
    pval_col=2,
    chr_col=3,
	pos_col=4,
	ea_col=5,
	oa_col=6,
	eaf_col=7,
	beta_col=11,
	se_col=12
))
x$format_dataset()
x$api_gwasdata_upload()
l$eur <- x


x <- Dataset$new(filename="EAGLE_Multi_ancestry_summary_data_2022_no_NA.tsv")
x$collect_metadata(list(
	ontology="EFO:0000274",
	trait="Atopic dermatitis",
	population = "Mixed",
	sex="Males and Females",
	author="Budu-Aggrey A",
	consortium="EAGLE",
	ncase=65107,
    ncontrol=1021287,
    sample_size=65107+1021287,
	year=2022,
	build="HG19/GRCh37",
	unit="logOR",
	group_name = "public",
	category="Disease",
	subcategory="NA"
))
x$api_metadata_upload()
x$determine_columns(list(
	snp_col=1,
    pval_col=2,
    chr_col=3,
	pos_col=4,
	ea_col=5,
	oa_col=6,
	eaf_col=7,
	beta_col=11,
	se_col=12
))
x$format_dataset()
x$api_gwasdata_upload()
l$eur <- x
