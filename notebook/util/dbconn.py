from sqlalchemy import create_engine

DEFAULT_CONNECTION = {
    'password': 'qshOke46RvOg0',
    'host': 'localhost',
    'port': '8084',
    'dbname': 'ecommerce'
}


def get_conn_string(conn_dict=None):
    conn_dict = (conn_dict
                 if conn_dict is not None
                 else DEFAULT_CONNECTION)
    
    return ('postgresql://postgres:'
            + conn_dict['password']
            + '@'
            + conn_dict['host']
            + ':'
            + conn_dict['port']
            + '/'
            + conn_dict['dbname'])


class DbConn:
    def __init__(self, conn_dict=None):
        self.connection_string = get_conn_string(conn_dict)
    
    def get_engine(self):
        return create_engine(self.connection_string)
