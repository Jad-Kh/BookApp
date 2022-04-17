from django.http import JsonResponse
from bookapp.models.book import Book
from bookapp.serializers.bookserializer import BookSerializer

def book_list(request):
    books = Book.objects.all()
    serializer = BookSerializer(books, many=True)
    return JsonResponse(serializer.data, safe=False)
