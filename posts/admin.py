from django.contrib import admin

from .models import Post, Category, Comment, Report

admin.site.register(Post)
admin.site.register(Category)
admin.site.register(Comment)
admin.site.register(Report)
