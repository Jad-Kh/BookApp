from django.db import models

class User(models.Model):
    id = models.IntegerField(unique=True, primary_key=True)
    username = models.CharField(max_length=50)
    email = models.EmailField(max_length=100, unique=True)
    password = models.CharField(max_length=50)
    createdAt = models.DateTimeField(auto_now_add=True)