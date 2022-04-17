from rest_framework import serializers
from bookapp.models.book import Book

class BookSerializer(serializers.ModelSerializer):
    class Meta:
        model = Book
        fields = '__all__'