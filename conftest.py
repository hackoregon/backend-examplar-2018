import pytest
import os
import dead_songs

@pytest.fixture(scope='session')
def django_db_setup():
    backend.settings.DATABASES['default'] = {
        'ENGINE': 'django_db_geventpool.backends.postgresql_psycopg2',
        'PASSWORD': os.environ.get('POSTGRES_PASSWORD'),
        'NAME': os.environ.get('POSTGRES_NAME'),
        'USER': os.environ.get('POSTGRES_USER'),
        'HOST': os.environ.get('POSTGRES_HOST'),
        'PORT': os.environ.get('POSTGRES_PORT'),
        'CONN_MAX_AGE': 0,
        'OPTIONS': {
            'MAX_CONNS': 20
        }
    }