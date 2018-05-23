
import pymssql
import mysql.connector

"""
"""
from config_db import config_db

"""
"""
class connection_db:

	"""
	"""
	def __init__(self):
		self.config_db = config_db()

	"""
	"""
	def remote_execute_sql_noreturn(self, sql_sentence):
		# Connection
		parms_db = self.config_db.get_remote_db_parms()
		conn = pymssql.connect(server=parms_db["host"], user=parms_db["user"], password=parms_db["password"], database=parms_db["database"])
		cursor = conn.cursor()

		# Sentence execution
		cursor.execute(sql_sentence)
		row = cursor.fetchone()
		while row:
			row = cursor.fetchone()  
		conn.commit()
		conn.close()

	"""
	"""
	def remote_execute_sql_table_return(self, sql_sentence):
		table = []
		# Connection
		parms_db = self.config_db.get_remote_db_parms()
		conn = pymssql.connect(server=parms_db["host"], user=parms_db["user"], password=parms_db["password"], database=parms_db["database"])

		# Sentence execution
		cursor = conn.cursor()
		cursor.execute(sql_sentence)
		row = cursor.fetchone()
		while row:
			table.append(row)
			row = cursor.fetchone()
		conn.close()
		return table

	"""
	"""
	def local_execute_sql_noreturn(self, sql_sentence):
		# Connection
		parms_db = self.config_db.get_local_db_parms()
		conn = mysql.connector.connect(**parms_db)
		cursor = conn.cursor()

		# Sentence execution
		cursor.execute(sql_sentence, ())
		emp_no = cursor.lastrowid
		conn.commit()

		cursor.close()
		conn.close()

	"""
	"""
	def local_execute_sql_table_return(self, sql_sentence):
		table = []
		# Connection
		parms_db = self.config_db.get_local_db_parms()
		conn = mysql.connector.connect(**parms_db)
		cursor = conn.cursor()

		cursor.execute(sql_sentence, ())

		for row in cursor:
		  table.append(row)

		cursor.close()
		cnx.close()
		return table

	"""
	"""
	def local_execute_sql_escalar_return(self, sql_sentence):
		table = []
		# Connection
		parms_db = self.config_db.get_local_db_parms()
		conn = mysql.connector.connect(**parms_db)
		cursor = conn.cursor()

		cursor.execute(sql_sentence, ())

		for row in cursor:
		  table.append(row)

		cursor.close()
		cnx.close()
		return table