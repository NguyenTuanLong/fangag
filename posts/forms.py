from django import forms
from .models import Post, Comment
from django.core.exceptions import ValidationError


class PostForm(forms.ModelForm):
    class Meta:
        model = Post
        fields = ('title', 'categories', 'image', 'video')
    
    def clean(self):
        cleaned_data = super().clean()
        image = cleaned_data.get("image")
        video = cleaned_data.get("video")
        if image and video:
            raise ValidationError("Only video or image")
        if not image and not video:
            raise ValidationError("Fill video or image")





class CommentForm(forms.ModelForm):
    content = forms.CharField(label='Comment', required=True, widget=forms.Textarea(attrs={
        'class': 'form-control',
        'id': 'content',
        'rows': '4',
    }))
    image = forms.ImageField(required=False)

    class Meta:
        model = Comment
        fields = ('content', 'image')
