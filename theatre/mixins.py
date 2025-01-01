import logging
from django.db import transaction

class TransactionMixin:
    def create(self, validated_data):
        with transaction.atomic():
            return super().create(validated_data)

    def update(self, instance, validated_data):
        with transaction.atomic():
            return super().update(instance, validated_data)


class LoggingMixin:
    def log_creation(self, instance):
        logger = logging.getLogger(__name__)
        logger.info(f"Created {instance.__class__.__name__} with ID {instance.id}")

