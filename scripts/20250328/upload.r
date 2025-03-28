library(ieugwasr)
library(GwasDataImport)
library(readxl)

md <- readxl::read_xlsx("mz_annotations.xlsx")
md$id <- NA

l <- list()
for(i in 1:nrow(md)) {
    message(i)

    x <- Dataset$new(filename=file.path("~/Downloads/sumstats_OpenGWAS", md$filename[i]))

    x$filename <- file.path("~/Downloads/sumstats_OpenGWAS", md$filename[i])
    x$collect_metadata(list(
        trait=md$trait[i],
        group_name="public",
        build="HG19/GRCh37",
        category=md$category[i],
        subcategory=md$subcategory[i],
        ontology=md$efo_ontology[i],
        population=md$population[i],
        sex=md$sex[i],
        sample_size=md$sample_size[i],
        author=md$author[i],
        year=md$year[i],
        unit=md$measurement_units[i],
        sd=md$trait_standard_deviation[i],
        consortium=md$consortium[i],
        note=md$note[i]
    ))
    x$api_metadata_upload()

    x$determine_columns(list(
        snp_col=1,
        chr_col=2,
        pos_col=3,
        ea_col=4,
        oa_col=5,
        eaf_col=6,
        beta_col=7,
        se_col=8,
        pval_col=9,
        ncontrol_col=10
    ))

    x$format_dataset()

    x$api_gwasdata_upload()
    md$id[i] <- x$igd_id
    l[[i]] <- x$clone()
}

