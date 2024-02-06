if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform(data, *args, **kwargs):
    """
    Template code for a transformer block.

    Add more parameters to this function if this block has multiple parent blocks.
    There should be one parameter for each output variable from each parent block.

    Args:
        data: The output from the upstream parent block
        args: The output from any additional upstream blocks (if applicable)

    Returns:
        Anything (e.g. data frame, dictionary, array, int, str, etc.)
    """
    # Specify your transformation logic here

    # show initial metadata
    print(f'Starting with {len(data)}x{len(data.columns)} in dataset.')
    print(f'Rows with zero passengers: ',data.passenger_count.isin([0]).sum())
    print(f'Rows with zero trip_distance: ',data.trip_distance.isin([0]).sum())

    # remove records of trips with no passengers
    data = data.loc[data.passenger_count>0]
    data = data.loc[data.trip_distance>0]
    print(f'After removing rows with no passengers or zero trip_distance, {len(data)} rows remain.')

    # create column for the pick-up date using pick-up datetime
    data.lpep_pickup_datetime.dtype
    data['lpep_pickup_date'] = data.lpep_pickup_datetime.dt.date

    # rename some columns
    data = data.rename(
        columns = {
            'VendorID':'vendor_id',
            'RatecodeID':'rate_code_id',
            'PULocationID':'pu_location_id',
            'DOLocationID':'do_location_id'
        }
    )

    # what are the values of VendorID?
    print(f'vendor_id values: {data.vendor_id.unique()}')

    return data


@test
def test_column_rename(output, *args) -> None:
    assert 'vendor_id' in output.columns, 'vendor_id is not one of the columns.'
@test
def test_passenger_count(output, *args) -> None:
    assert output.passenger_count.isin([0]).sum()==0, 'There are trips with zero passengers.'
@test
def test_trip_distance(output, *args) -> None:
    assert output.trip_distance.isin([0]).sum()==0, 'There are trips with zero distance.'
