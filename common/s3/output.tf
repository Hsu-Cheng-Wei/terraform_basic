output "bucket_name" {
    value = "${module.core.prefix}-bucket-h7ihp"
}

output "bucket_directory" {
    value = [
        "media/",
        "log/"
    ]
}