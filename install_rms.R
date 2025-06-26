#il faut au préalable avoir installer Rtool sur le lien oficiel suivant https://cran.r-project.org/bin/windows/Rtools/rtools42/rtools.html
#choisir celui correspondant a sa version de R vérifier avec version()

#les indépendance du package rms
install.packages("htmltools")      # doit être ≥ 0.5.7
install.packages("htmlTable")
install.packages("Hmisc", dependencies = TRUE)
install.packages("polspline")
install.packages("multcomp")
install.packages("https://cran.r-project.org/src/contrib/Archive/MatrixModels/MatrixModels_0.5-0.tar.gz",
                 repos = NULL, type = "source")

#instaler une version anterieur de rms pour la version 4.2 de r studio
install.packages("https://cran.r-project.org/src/contrib/Archive/rms/rms_6.7-1.tar.gz",
                 repos = NULL, type = "source")
