from rest_framework import serializers

from .models import Gallery, Mesh, MeshImage


class MeshSerializer(serializers.ModelSerializer):
    class Meta:
        model = Mesh
        fields = "__all__"


class GallerySerializer(serializers.ModelSerializer):
    # images = serializers.PrimaryKeyRelatedField(
    #     many=True, queryset=MeshImage.objects.all()
    # )

    class Meta:
        model = Gallery
        fields = "__all__"


class MeshImageSerializer(serializers.ModelSerializer):
    class Meta:
        model = MeshImage
        fields = "__all__"
