# OpenGWAS manual uploads

OpenGWAS data can be uploaded via the API. The [GwasDataImport](https://github.com/mrcieu/gwasdataimport) R package can help with this process. For large datasets (e.g. >100 traits) it's better to use the batch process here https://github.com/MRCIEU/OpenGWAS-Elasticsearch-HPC/.


## Process

1. Create a directory named YYYYMMDD
2. Create a script YYYYMMDD/upload.r
3. Include the download command and then the metadata entry e.g.

	```
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
	```

4. Save the `Dataset` object as `obj.rds`. If there are multiple uploads in one script then save them as a list of objects.
5. Update the `inventory.txt` file that maps the directory name to the IDs that have been uploaded.

It may be necessary to download the file and format it in a separate script, or to create a spreadsheet with meta data etc for multiple file uplaods. This is fine, just make sure that the scripts run in a reproducible manner within the folder.

## Docker

The `GwasDataImport` package uses a few dependencies that can be difficult to install. This docker image has all the pre-requisites + `r/tidyverse` installed, you can run it using

```
docker build -t gwasdataimport .
docker run -it -v $(pwd):$(pwd) -w $(pwd) --name gwasdataimport gwasdataimport R
```

Just be aware that any temporary files generated will be inside the docker container. So if you stop the docker container then you can get back in there using

```
docker start gwasdataimport
docker exec -it gwasdataimport R
```
