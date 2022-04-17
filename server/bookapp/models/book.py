from django.db import models

class Book(models.Model):
    isbn = models.IntegerField(unique=True)
    title = models.CharField(max_length=50)
    publisher = models.CharField(max_length=30)
    date = models.CharField(max_length=15)
    description = models.CharField(max_length=4000)
    pages = models.IntegerField()
    categories = models.CharField(max_length=200)
    ratingaverage = models.IntegerField()
    ratingnumber = models.IntegerField()
    thumbnail = models.CharField(max_length=200)
    bigthumbnail = models.CharField(max_length=200)
