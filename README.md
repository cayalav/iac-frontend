# iac-frontend

Infraestructura mínima en Terraform para exponer un frontend estático sobre Amazon S3, CloudFront y Route 53.

## Requisitos previos

1. **Certificado de ACM en us-east-1**
   - Crea manualmente un certificado público en AWS Certificate Manager (región us-east-1) que cubra el dominio principal y los alias necesarios.
   - Valida el certificado y copia el ARN; lo necesitarás en `acm_certificate_arn` dentro de tus archivos `.tfvars`.
2. **Hosted Zone en Route 53**
   - Si prefieres reutilizar una zona existente, crea o identifica una hosted zone pública para el dominio y registra su `Hosted Zone ID`.
   - Si quieres que Terraform cree la zona por ti, asegúrate de establecer `create_hosted_zone = true` y delega manualmente los name servers que se mostrarán en la salida `route53_name_servers`.
3. **Credenciales de AWS**
   - Exporta las variables de entorno `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY` y, si aplica, `AWS_SESSION_TOKEN` antes de ejecutar Terraform.
4. **Bucket de estado remoto**
   - Verifica que el bucket S3 `tf-state-448261840709` exista y que tengas permisos de lectura/escritura.

## Uso

1. Clona el repositorio y entra al directorio `iac-frontend`.
2. Duplica `terraform.tfvars.example` o usa `terraform.test.tfvars` como base para tus variables.
3. Ejecuta `terraform init -reconfigure` para inicializar el backend remoto.
4. Lanza `terraform plan -var-file=tu-archivo.tfvars` para revisar los cambios.
5. Aplica los cambios con `terraform apply -var-file=tu-archivo.tfvars` cuando estés listo.

## Salidas

- `site_bucket_name`: nombre del bucket que aloja los assets.
- `cloudfront_distribution_id` y `cloudfront_domain_name`: información de la distribución que sirve el sitio.
- `route53_name_servers`: se llena sólo si Terraform crea la hosted zone; delega estos NS en tu registrador.
