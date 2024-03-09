from django.contrib import admin

from .models import Gallery, Mesh, MeshImage


@admin.register(Mesh)
class MeshAdmin(admin.ModelAdmin):
    pass


@admin.register(Gallery)
class GalleryAdmin(admin.ModelAdmin):
    pass


@admin.register(MeshImage)
class MeshImageAdmin(admin.ModelAdmin):
    pass
