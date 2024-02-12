import io
import pandas as pd
import requests
if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@data_loader
def load_data_from_api(*args, **kwargs):
    """
    loads data from Green NY Taxi data repository for specified months
    """
    # specified months to pull data for
    months = range(1,13)

    # datatypes for loading    
    taxi_dtypes:dict = {
                    'VendorID': pd.Int64Dtype(),
                    'passenger_count': pd.Int64Dtype(),
                    'trip_distance': float,
                    'RatecodeID':pd.Int64Dtype(),
                    'store_and_fwd_flag':str,
                    'PULocationID':pd.Int64Dtype(),
                    'DOLocationID':pd.Int64Dtype(),
                    'payment_type': pd.Int64Dtype(),
                    'fare_amount': float,
                    'extra':float,
                    'mta_tax':float,
                    'tip_amount':float,
                    'tolls_amount':float,
                    'improvement_surcharge':float,
                    'total_amount':float,
                    'congestion_surcharge':float,
                    'ehail_fee':float,
                    'trip_type':pd.Int64Dtype()
                }

    # date columns for native date parsing 
    parse_dates:list = ['lpep_pickup_datetime', 'lpep_dropoff_datetime']

    # get data for required months

        # dataframe for the whole set
    df = pd.DataFrame()
        # iterate through months and concat to full dataframe
    for m in months:
        url = f'https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2022-{m:02d}.parquet'.format(m)
        print('url: ', url)
        print(f'Downloading data from {url}')
        df_m = pd.read_parquet(url)
        df = pd.concat(
            [df,df_m],
            axis = 0
        )

    return df

@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'