# release-the-code-litecoin


## Docker

The Dockerfile builds an image of litecoin and runs as a daemon on startup i.e. `docker-compose`. The Dockerfile specifies targets for each of the stages so that docker-compose can target them and make building easier.

### docker-compose

docker-compose was used because it makes working with the image a little easier without having to type out long `docker ...` commands. For instance instead of `docker build -t ghcr.io/brandoncamenisch/release-the-code-litecoin/litecoin:0.18.1 .` one can simply type `docker-compose build`. The same is true for other general docker commands you might run while working with docker.
### Building the image

The litecoin version is pinned to `0.18.1` in the `docker-compose.yml` file. Running `docker-compose build` is all you need to build the image.

### Running the image

`docker-compose run lettherebelite`

#### Docker Image Vuln Scanning

- Docker image vulnerability scanning happens in two ways as part of this repository
-- Automatically in GitHub Actions
-- Or manually as a docker image... `docker run -v /var/run/docker.sock:/var/run/docker.sock -it anchore/grype lettherebelite:latest`

When running the scan you should see an output similar to this...

```bash
$ docker run -v /var/run/docker.sock:/var/run/docker.sock -it anchore/grype release-the-code-litecoin_lettherebelite
 ✔ Vulnerability DB        [updated]
 ✔ Loaded image            
 ✔ Parsed image            
 ✔ Cataloged packages      [102 packages]
 ✔ Scanned image           [25 vulnerabilities]
NAME              INSTALLED           FIXED-IN          VULNERABILITY     SEVERITY   
coreutils         8.32-4ubuntu2                         CVE-2016-2781     Low         
krb5-locales      1.18.3-4                              CVE-2021-36222    Medium      
krb5-locales      1.18.3-4                              CVE-2018-5709     Negligible  
libc-bin          2.33-0ubuntu5                         CVE-2016-10228    Negligible  
libc-bin          2.33-0ubuntu5                         CVE-2020-29562    Low         
libc-bin          2.33-0ubuntu5                         CVE-2019-25013    Low         
libc6             2.33-0ubuntu5                         CVE-2016-10228    Negligible  
libc6             2.33-0ubuntu5                         CVE-2020-29562    Low         
libc6             2.33-0ubuntu5                         CVE-2019-25013    Low         
libgcrypt20       1.8.7-2ubuntu2      1.8.7-2ubuntu2.1  CVE-2021-33560    Low         
libgcrypt20       1.8.7-2ubuntu2      1.8.7-2ubuntu2.1  CVE-2021-40528    Medium      
libgssapi-krb5-2  1.18.3-4                              CVE-2021-36222    Medium      
libgssapi-krb5-2  1.18.3-4                              CVE-2018-5709     Negligible  
libk5crypto3      1.18.3-4                              CVE-2021-36222    Medium      
libk5crypto3      1.18.3-4                              CVE-2018-5709     Negligible  
libkrb5-3         1.18.3-4                              CVE-2021-36222    Medium      
libkrb5-3         1.18.3-4                              CVE-2018-5709     Negligible  
libkrb5support0   1.18.3-4                              CVE-2021-36222    Medium      
libkrb5support0   1.18.3-4                              CVE-2018-5709     Negligible  
libpcre3          2:8.39-13build3                       CVE-2017-11164    Negligible  
libpcre3          2:8.39-13build3                       CVE-2019-20838    Low         
libtasn1-6        4.16.0-2                              CVE-2018-1000654  Negligible  
login             1:4.8.1-1ubuntu8.1                    CVE-2013-4235     Low         
passwd            1:4.8.1-1ubuntu8.1                    CVE-2013-4235     Low         
tar               1.34+dfsg-1build1                     CVE-2019-9923     Low         
```

## Terraform

To deploy the terraform code you must `cd terraform && terraform init && terraform plan|apply`. There's no backend configured since this is an example. The terraform IAM example is using the official [terraform-aws-modules!](https://github.com/terraform-aws-modules/terraform-aws-iam). Normally I opt to use something off the shelf if it fits the use case and is well trusted rather than spending valuable time creating the same thing.