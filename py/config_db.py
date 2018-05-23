
"""
"""
class config_db:

	"""
	"""
	def __init__(self):
		self.remote = {
			  'user': 'sa',
			  'password': 'Test.01',
			  'host': '192.168.56.103\\DEV',
			  'database': 'TIJ',
			}

		self.local = {
			  'user': 'developer',
			  'password': 'Test.01',
			  'host': 'localhost',
			  'database': 'reports',
			  'raise_on_warnings': True,
			}


	"""
	"""
	def get_remote_db_parms(self):
		return self.remote

	"""
	"""
	def get_local_db_parms(self):
		return self.local
