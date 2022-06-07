# redshift parameters to connect to Amazon Redshift cluster
HOST = 'redshift-cluster-2.cc91axnb6oda.eu-west-3.redshift.amazonaws.com'
DATABASE = 'callpanda_prod'
PORT = 5439
USER = 'awsuser'
PASSWORD = '48D7Pcw8zz3Z6bpGhPXN'

# S3 parameters
S3_CREDENTIALS = 'aws_iam_role=arn:aws:iam::061095659895:role/CallPandaAnalyticsS3Redshift'
S3_REGION = 'eu-west-3'
S3_FILE_PATH_TO_DATA = 's3://callpanda-analytics-test/prod/csv/callpanda_prod_'