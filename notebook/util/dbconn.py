import psycopg2

DEFAULT_CONNECTION = {
    'password': 'qshOke46RvOg0',
    'host': '35.184.46.9',
    'port': '8084',
    'dbname': 'ecommerce',
    'user': 'postgres'
}


# For sqlalchemy
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


def get_conn_dict(conn_dict=None):
    conn_dict = (conn_dict
                if conn_dict is not None
                else DEFAULT_CONNECTION)
    
    return conn_dict


class DbConn:
    def __init__(self, conn_dict=None):
        self.connection = get_conn_dict(conn_dict)
    
    def get_conn(self):
        config = self.connection
        return psycopg2.connect(dbname=config['dbname'],
                                user=config['user'],
                                password=config['password'],
                                host=config['host'],
                                port=config['port'])
