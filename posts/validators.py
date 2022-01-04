def validate_file(value):
    import os
    from django.core.exceptions import ValidationError
    filesize= value.size
    ext = os.path.splitext(value.name)[1]  # [0] returns path+filename
    valid_extensions = ['.mp4', '.gif']
    if not ext.lower() in valid_extensions:
        raise ValidationError('Unsupported file extension.')
    elif filesize > 26214400:
        raise ValidationError("The maximum file size that can be uploaded is 25MB")
    else:
        return value

