from django.db import models

MAX_LENGTH_NAME = 256


# def mesh_upload_path(instance, filename):
#     return f"/mesh/{filename}"


# def gallery_image_upload_path(instance, filename):
#     return f"/img/{filename}"

# TODO: Модель Gallery, модель MeshImage; Gallery.images = List(MeshImage) (FK)
# TODO: Загрузка из аплодера автоматическая, без multiple и т.д.
# TODO: По кнопке "Создать" отправка запроса, создание модели, обновление списка и текущей модели


def image_upload_path(instance, filename):
    return f"images/{filename}"


class MeshImage(models.Model):
    src = models.ImageField("Фото", upload_to="images/")

    def __str__(self) -> str:
        return self.src.name.removeprefix("images/")


class Gallery(models.Model):
    """
    Исходные фото модели
    """

    name = models.CharField("Название", max_length=MAX_LENGTH_NAME)
    # images = models.ForeignKey(
    #     MeshImage,
    #     verbose_name="Фотографии",
    #     on_delete=models.DO_NOTHING,
    #     null=True,
    # )
    images = models.ManyToManyField(
        MeshImage,
        verbose_name="Фотографии",
        null=True,
    )

    class Meta:
        verbose_name = "Фото модели"
        verbose_name_plural = "Фото моделей"

    def __str__(self) -> str:
        return f"{self.name} ({self.id})"


class Mesh(models.Model):
    name = models.CharField("Имя", max_length=MAX_LENGTH_NAME)
    date_created = models.DateTimeField("Создано", auto_now_add=True)
    mesh = models.FileField("Файл", upload_to="mesh/", blank=True, null=True)
    gallery = models.OneToOneField(
        Gallery,
        verbose_name="Фото",
        on_delete=models.DO_NOTHING,
        null=True,
        blank=True,
    )

    class Meta:
        verbose_name = "Модель"
        verbose_name_plural = "Модели"

    def __str__(self) -> str:
        return self.name
