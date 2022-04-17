from bookapp.models.user import User
from rest_framework import viewsets, permissions
from bookapp.serializers.userserializer import UserSerializer

class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all()
    permission_classes = [
        permissions.AllowAny
    ]
    serializer_class = UserSerializer