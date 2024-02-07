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

    data=data[(data['passenger_count']>0) & (data['trip_distance'])>0]
    data['lpep_pickup_date']=data['lpep_pickup_datetime'].dt.date
    
    data.columns = data.columns.str.replace('(?<=[a-z])(?=[A-Z])', '_', regex=True).str.lower()
    
    print(data['vendor_id'].unique())
    return data


@test
def test_output(output, *args) -> None:
    assert output['vendor_id'].isin([1, 2]).all(), 'vendor_id is same as existing values'

@test
def test_output(output, *args) -> None:
    assert (output['passenger_count']>0).all(), 'The passenger count is more than 0 for all passengers'

@test
def test_output(output, *args) -> None:
    assert (output['trip_distance']>0).all(), 'The trip distance is more than 0 for all passengers'