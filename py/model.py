from connection_db import connection_db
import datetime

"""
"""
class model:
	"""
	"""
	def __init__(self):
		self.conn = connection_db()

	"""
		parms = ( from_date, to_date, id_runtime )
	"""
	def create_stops(self, parms):
		# remote execution
		"""
			SELECT
				  [M6].[Maquina]
				, [M6].[INICIOPARO]
				, [MP].[IdParo]
				, [MP].[TipoParo]
				, [MP].[Clasificacion]
				, DATEDIFF(MINUTE,[M6].[INICIOPARO],(CASE WHEN [M6].[FINPARO] > @ToDate THEN @ToDate ELSE [M6].[FinParo] END)) AS [StopTime]
			FROM
				[dbo].[MOLDAT06] [M6]
				LEFT JOIN [dbo].[MOLDEO_PAROS] [MP] ON
					[MP].[IdParo] = [M6].[IDPARO]
			WHERE 
					[M6].[INICIOPARO] >= @FromDate AND [M6].[INICIOPARO] < @ToDate
				AND [MP].[IdParo] <> 'PFIN'
		"""
		sql_sentence =  "SELECT [M6].[Maquina], [M6].[InicioParo], [MP].[IdParo], [MP].[TipoParo], [MP].[Clasificacion], DATEDIFF(MINUTE,[M6].[InicioParo],(CASE WHEN [M6].[FinParo] > '%s' THEN '%s' ELSE [M6].[FinParo] END)) AS [StopTime] FROM [dbo].[MOLDAT06] [M6] LEFT JOIN [dbo].[MOLDEO_PAROS] [MP] ON [MP].[IdParo] = [M6].[IdParo] WHERE [M6].[InicioParo] >= '%s' AND [M6].[InicioParo] < '%s' AND [MP].[IdParo] <> 'PFIN';" % (parms[1], parms[1], parms[0], parms[1])
		table = self.conn.remote_execute_sql_table_return(sql_sentence)

		# delete previuos rows
		sql_sentence = "delete from apq_stops where idruntime = %s;" % parms[2]
		self.conn.local_execute_sql_noreturn(sql_sentence)

		# local execution
		for row in table:
			sql_sentence = "insert into apq_stops (idruntime, idequipment, date, idparo, tipoparo, clasification, time) values ( %s, '%s', '%s', '%s', '%s', '%s', %s);" % ( parms[2], row[0], unicode(row[1]), row[2], row[3], row[4], row[5] )
			self.conn.local_execute_sql_noreturn(sql_sentence)

	"""
		parms = ( from_date, to_date, id_runtime )
	"""
	def create_counts(self, parms):
		# remote execution
		"""
			DELETE FROM [dbo].[APQ_Counts] WHERE [IdRuntime] = @IdRuntime

			INSERT INTO [dbo].[APQ_Counts]
			SELECT
				  [IO].[ItemId]
				, [CM].[Maquina]
				, [IO].[EntryDate]
				, [TP].[ProdTime]
				, (CASE WHEN [IO].[IdPlace] IN (6, 10, 16) THEN 0 ELSE [IO].[QtyOut] END)					AS [GoodCount]
				, (CASE WHEN [IO].[IdPlace] IN (6, 10, 16) THEN [IO].[QtyOut] ELSE 0 END)					AS [BadCount]
				, [IO].[QtyOut]																				AS [TotalCount]
				, (CASE WHEN [IO].[IdPlace] IN (6, 10, 16) THEN 0 ELSE [IO].[QtyOut] END) * [TP].[ProdTime] AS [GoodTime] 
				, (CASE WHEN [IO].[IdPlace] IN (6, 10, 16) THEN [IO].[QtyOut] ELSE 0 END) * [TP].[ProdTime] AS [LostTime]
				, [IO].[QtyOut] * [TP].[ProdTime]															AS [TotalTime]
			FROM
				[dbo].[InvtMold_Output] [IO]
				INNER JOIN [dbo].[MOLDAT05] [M5] ON
						[M5].[IdOut] = [IO].[IdOut]
					AND [M5].[Estatus] = 'A'
				INNER JOIN [dbo].[CambioMolde] [CM] ON
						[CM].[IdCambioMolde] = [M5].[WO]
					AND [CM].[Estatus] = 'A'
				INNER JOIN [dbo].[v_Table_Plastic] [TP] ON
					[TP].[ItemId] = [IO].[ItemId]
			WHERE
				[IO].[EntryDate] >= @FromDate AND [IO].[EntryDate] < @ToDate

			INSERT INTO [dbo].[APQ_Counts]
			SELECT
				  [IO].[ItemId]
				, [CM].[Maquina]
				, [IO].[EntryDate]
				, [TP].[ProdTime]
				, 0									AS [GoodCount]
				, [IO].[QtyOut]						AS [BadCount]
				, [IO].[QtyOut]						AS [TotalCount]
				, 0									AS [GoodTime] 
				, ([IO].[QtyOut]*[TP].[ProdTime])	AS [LostTime]
				, ([IO].[QtyOut]*[TP].[ProdTime])	AS [TotalTime]
			FROM
				[dbo].[InvtMold_Output] [IO]
				INNER JOIN [dbo].[MOLDAT02] [M2] ON
					[M2].[IdOut] = [IO].[IdOut]
				INNER JOIN [dbo].[CambioMolde] [CM] ON
						[CM].[IdCambioMolde] = [M2].[WO]
					AND [CM].[Estatus] = 'A'
				INNER JOIN [dbo].[v_Table_Plastic] [TP] ON
					[TP].[ItemId] = [IO].[ItemId]
			WHERE
				[IO].[EntryDate] >= @FromDate AND [IO].[EntryDate] < @ToDate
		"""
		sql_sentence = "SELECT [IO].[ItemId], [CM].[Maquina], [IO].[EntryDate], [TP].[ProdTime], (CASE WHEN [IO].[IdPlace] IN (6, 10, 16) THEN 0 ELSE [IO].[QtyOut] END) AS [GoodCount], (CASE WHEN [IO].[IdPlace] IN (6, 10, 16) THEN [IO].[QtyOut] ELSE 0 END) AS [BadCount], [IO].[QtyOut] AS [TotalCount], (CASE WHEN [IO].[IdPlace] IN (6, 10, 16) THEN 0 ELSE [IO].[QtyOut] END) * [TP].[ProdTime] AS [GoodTime], (CASE WHEN [IO].[IdPlace] IN (6, 10, 16) THEN [IO].[QtyOut] ELSE 0 END) * [TP].[ProdTime] AS [LostTime], [IO].[QtyOut] * [TP].[ProdTime] AS [TotalTime] FROM [dbo].[InvtMold_Output] [IO] INNER JOIN [dbo].[MOLDAT05] [M5] ON [M5].[IdOut] = [IO].[IdOut] AND [M5].[Estatus] = 'A' INNER JOIN [dbo].[CambioMolde] [CM] ON [CM].[IdCambioMolde] = [M5].[WO] AND [CM].[Estatus] = 'A' INNER JOIN [dbo].[v_Table_Plastic] [TP] ON [TP].[ItemId] = [IO].[ItemId] WHERE [IO].[EntryDate] >= '%s' AND [IO].[EntryDate] < '%s';" % ( parms[0], parms[1] )
		table1 = self.conn.remote_execute_sql_table_return(sql_sentence)

		sql_sentence ="SELECT [IO].[ItemId], [CM].[Maquina], [IO].[EntryDate], [TP].[ProdTime], 0 AS [GoodCount], [IO].[QtyOut]	AS [BadCount], [IO].[QtyOut] AS [TotalCount], 0 AS [GoodTime], ([IO].[QtyOut]*[TP].[ProdTime]) AS [LostTime], ([IO].[QtyOut]*[TP].[ProdTime]) AS [TotalTime] FROM [dbo].[InvtMold_Output] [IO] INNER JOIN [dbo].[MOLDAT02] [M2] ON [M2].[IdOut] = [IO].[IdOut] INNER JOIN [dbo].[CambioMolde] [CM] ON [CM].[IdCambioMolde] = [M2].[WO] AND [CM].[Estatus] = 'A' INNER JOIN [dbo].[v_Table_Plastic] [TP] ON [TP].[ItemId] = [IO].[ItemId] WHERE [IO].[EntryDate] >= '%s' AND [IO].[EntryDate] < '%s';" % ( parms[0], parms[1] )
		table2 = self.conn.remote_execute_sql_table_return(sql_sentence)

		# delete previuos rows
		sql_sentence = "delete from apq_counts where idruntime = %s;" % parms[2]
		self.conn.local_execute_sql_noreturn(sql_sentence)

		# local execution
		table = table1 + table2
		for row in table:
			sql_sentence = "insert into apq_counts (idruntime, itemid, idequipment, date, cycletime, goodcount, badcount, totalcount, goodtime, losstime, totaltime) values ( %s, '%s', '%s', '%s', %s, %s, %s, %s, %s, %s, %s);" % ( parms[2], row[0], row[1], unicode(row[2]), row[3], row[4], row[5], row[6], row[7], row[8], row[9] )
			self.conn.local_execute_sql_noreturn(sql_sentence)

	"""
		parms = ( from_date, to_date, id_runtime )
	"""
	def create_equipments(self, parms):
		# remote execution
		"""
			DELETE FROM [dbo].[APQ_Equipment] WHERE [IdRuntime] = @IdRuntime

			SELECT
				  [M2].[Maquina]
				, CAST([M2].[PoderMaq] AS INT)
				, [M2].[Area]
				, [M2].[Linea]
			FROM
				[MACHINES02] [M2]
			WHERE
				[M2].[Estatus] <> 'E'
		"""
		sql_sentence =  "SELECT [M2].[Maquina], CAST([M2].[PoderMaq] AS INT), [M2].[Area], [M2].[Linea] FROM [dbo].[MACHINES02] [M2] WHERE [M2].[Estatus] <> 'E';"
		table = self.conn.remote_execute_sql_table_return(sql_sentence)

		# delete previuos rows
		sql_sentence = "delete from apq_equipment where idruntime = %s;" % parms[2]
		self.conn.local_execute_sql_noreturn(sql_sentence)

		# local execution
		for row in table:
			sql_sentence = "insert into apq_equipment( idruntime, idequipment, power, area, line ) values ( %s, '%s', %s, %s, %s);" % ( parms[2], row[0], row[1], row[2], row[3] )
			self.conn.local_execute_sql_noreturn(sql_sentence)

	"""
		parms = ( from_date, to_date, id_runtime )
	"""
	def create_prodtimes(self, parms):
		# remote execution
		"""
			DELETE FROM [dbo].[APQ_ProdTimes] WHERE [IdRuntime] = @IdRuntime

			SELECT
				  [CM].[IdCambioMolde]
				, [CM].[Maquina]
		--		, [M3].[HrIniCambio]
		--		, [M3].[HrFinCambio]
		--		, [M3].[HrIniMaq]
				, ISNULL([M3].[HrIniProd],@FromDate)
				, (CASE WHEN ISNULL([CM].[FechaParo], @ToDate) > @ToDate THEN @ToDate ELSE ISNULL([CM].[FechaParo], @ToDate) END)
				, DATEDIFF(MINUTE, ISNULL([M3].[HrIniProd],@FromDate), (CASE WHEN ISNULL([CM].[FechaParo], @ToDate) > @ToDate THEN @ToDate ELSE ISNULL([CM].[FechaParo], @ToDate) END))	AS [Minutes]
			FROM
				[dbo].[CAMBIOMOLDE] [CM]
				LEFT JOIN [MOLDAT03] [M3] ON
					[M3].[WO] = [CM].[IdCambioMolde]
			WHERE
					[CM].[Estatus]	= 'A'
				AND [CM].[FechaCambio] >= @FromDate AND [CM].[FechaCambio] < @ToDate
		"""
		sql_sentence =  "SELECT [CM].[IdCambioMolde], [CM].[Maquina], ISNULL([M3].[HrIniProd],'%s'), (CASE WHEN ISNULL([CM].[FechaParo], '%s') > '%s' THEN '%s' ELSE ISNULL([CM].[FechaParo], '%s') END), DATEDIFF(MINUTE, ISNULL([M3].[HrIniProd],'%s'), (CASE WHEN ISNULL([CM].[FechaParo], '%s') > '%s' THEN '%s' ELSE ISNULL([CM].[FechaParo], '%s') END))	AS [Minutes] FROM [dbo].[CAMBIOMOLDE] [CM] LEFT JOIN [MOLDAT03] [M3] ON [M3].[WO] = [CM].[IdCambioMolde] WHERE [CM].[Estatus] = 'A' AND [CM].[FechaCambio] >= '%s' AND [CM].[FechaCambio] < '%s';" % (parms[0], parms[1], parms[1], parms[1], parms[1], parms[0], parms[1], parms[1], parms[1], parms[1], parms[0], parms[1])
		table = self.conn.remote_execute_sql_table_return(sql_sentence)

		# delete previuos rows
		sql_sentence = "delete from apq_prodtimes where idruntime = %s;" % parms[2]
		self.conn.local_execute_sql_noreturn(sql_sentence)

		# local execution
		for row in table:
			sql_sentence = "insert into apq_prodtimes( idruntime, workorder, idequipment, starttime, endtime, time ) values ( %s, '%s', '%s', '%s', '%s', %s);" % ( parms[2], row[0], row[1], unicode(row[2]), unicode(row[3]), row[4] )
			self.conn.local_execute_sql_noreturn(sql_sentence)


	"""
		parms = ( from_date, to_date, id_runtime )
	"""
	def create_setup_and_starts(self, parms):
		# remote execution
		"""
			DELETE FROM [dbo].[APQ_SetupAndStart] WHERE [IdRuntime] = @IdRuntime

			SELECT
				  [CM].[IdCambioMolde]
				, [CM].[Maquina]
				, [CM].[fechacambio]
				, [PP].[US MOLD #]
				, (CASE
					WHEN [M3].[HrIniCambio] IS NULL OR [M3].[HrFinCambio] IS NULL THEN DATEPART(HOUR,[ML].[STDMolde])*60 + DATEPART(MINUTE,[ML].[STDMolde])
					ELSE DATEDIFF(MINUTE, [M3].[HrIniCambio], [M3].[HrFinCambio])
				END)	AS [ActualSetupTime]
				, (CASE
					WHEN [M3].[HrIniMaq] IS NULL OR [M3].[HrIniProd] IS NULL THEN DATEPART(HOUR,[ML].[STDInicio])*60 + DATEPART(MINUTE,[ML].[STDInicio])
					ELSE DATEDIFF(MINUTE, [M3].[HrIniMaq], [M3].[HrIniProd])
				END)	AS [ActualStartTime]
				, DATEPART(HOUR, [ML].[STDInicio])*60*60 + DATEPART(MINUTE, [ML].[STDInicio])*60	AS [Start]
				, DATEPART(HOUR, [ML].[STDMolde])*60*60 + DATEPART(MINUTE, [ML].[STDMolde])*60		AS [Setup]
			FROM
				[dbo].[CAMBIOMOLDE] [CM]
				LEFT JOIN [PARTS_PLASTIC] [PP] ON
					[PP].[No_PP] = [CM].[No_PP]
				LEFT JOIN [MOLDS] [ML] ON
					[ML].[MoldeTXT] = [PP].[US MOLD #]
			WHERE
				[CM].[FechaCambio] >= @FromDate AND [CM].[FechaCambio] < @ToDate
		"""
		sql_sentence = "SELECT [CM].[IdCambioMolde], [CM].[Maquina], [CM].[fechacambio], [PP].[US MOLD #], (CASE WHEN [M3].[HrIniCambio] IS NULL OR [M3].[HrFinCambio] IS NULL THEN DATEPART(HOUR,[ML].[STDMolde])*60 + DATEPART(MINUTE,[ML].[STDMolde]) ELSE DATEDIFF(MINUTE, [M3].[HrIniCambio], [M3].[HrFinCambio]) END)	AS [ActualSetupTime], (CASE	WHEN [M3].[HrIniMaq] IS NULL OR [M3].[HrIniProd] IS NULL THEN DATEPART(HOUR,[ML].[STDInicio])*60 + DATEPART(MINUTE,[ML].[STDInicio]) ELSE DATEDIFF(MINUTE, [M3].[HrIniMaq], [M3].[HrIniProd]) END) AS [ActualStartTime], DATEPART(HOUR, [ML].[STDInicio])*60*60 + DATEPART(MINUTE, [ML].[STDInicio])*60	AS [Start], DATEPART(HOUR, [ML].[STDMolde])*60*60 + DATEPART(MINUTE, [ML].[STDMolde])*60 AS [Setup] FROM [dbo].[CAMBIOMOLDE] [CM] LEFT JOIN [dbo].[Moldat03] [M3] ON [M3].[WO] = [CM].[IdCambioMolde] LEFT JOIN [dbo].[PARTS_PLASTIC] [PP] ON [PP].[No_PP] = [CM].[No_PP] LEFT JOIN [dbo].[MOLDS] [ML] ON [ML].[MoldeTXT] = [PP].[US MOLD #] WHERE [CM].[FechaCambio] >= '%s' AND [CM].[FechaCambio] < '%s';" % ( parms[0], parms[1] )
		table = self.conn.remote_execute_sql_table_return(sql_sentence)

		# delete previuos rows
		sql_sentence = "delete from apq_setupandstart where idruntime = %s;" % parms[2]
		self.conn.local_execute_sql_noreturn(sql_sentence)

		# local execution
		for row in table:
			sql_sentence = "insert into apq_setupandstart( idruntime, workorder, idequipment, date, idusm, actsetuptime, actstarttime, stdsetuptime, stdstarttime ) values ( %s, '%s', '%s', '%s', '%s', %s, %s, %s, %s);" % ( parms[2], row[0], row[1], unicode(row[2]), row[3], row[4], row[5], row[6], row[7] )
			self.conn.local_execute_sql_noreturn(sql_sentence)

	"""
		parms = ( from_date, to_date, id_runtime )
	"""
	def execute_runtime(self, parms):
		# 
		sql_sentence = "SELECT [CM].[IdCambioMolde], [CM].[Maquina], [CM].[fechacambio], [PP].[US MOLD #], (CASE WHEN [M3].[HrIniCambio] IS NULL OR [M3].[HrFinCambio] IS NULL THEN DATEPART(HOUR,[ML].[STDMolde])*60 + DATEPART(MINUTE,[ML].[STDMolde]) ELSE DATEDIFF(MINUTE, [M3].[HrIniCambio], [M3].[HrFinCambio]) END)	AS [ActualSetupTime], (CASE	WHEN [M3].[HrIniMaq] IS NULL OR [M3].[HrIniProd] IS NULL THEN DATEPART(HOUR,[ML].[STDInicio])*60 + DATEPART(MINUTE,[ML].[STDInicio]) ELSE DATEDIFF(MINUTE, [M3].[HrIniMaq], [M3].[HrIniProd]) END) AS [ActualStartTime], DATEPART(HOUR, [ML].[STDInicio])*60*60 + DATEPART(MINUTE, [ML].[STDInicio])*60	AS [Start], DATEPART(HOUR, [ML].[STDMolde])*60*60 + DATEPART(MINUTE, [ML].[STDMolde])*60 AS [Setup] FROM [dbo].[CAMBIOMOLDE] [CM] LEFT JOIN [dbo].[Moldat03] [M3] ON [M3].[WO] = [CM].[IdCambioMolde] LEFT JOIN [dbo].[PARTS_PLASTIC] [PP] ON [PP].[No_PP] = [CM].[No_PP] LEFT JOIN [dbo].[MOLDS] [ML] ON [ML].[MoldeTXT] = [PP].[US MOLD #] WHERE [CM].[FechaCambio] >= '%s' AND [CM].[FechaCambio] < '%s';" % ( parms[0], parms[1] )
		table = self.conn.remote_execute_sql_table_return(sql_sentence)

		# delete previuos rows
		sql_sentence = "delete from apq_setupandstart where idruntime = %s;" % parms[2]
		self.conn.local_execute_sql_noreturn(sql_sentence)

		# local execution
		for row in table:
			sql_sentence = "insert into apq_setupandstart( idruntime, workorder, idequipment, date, idusm, actsetuptime, actstarttime, stdsetuptime, stdstarttime ) values ( %s, '%s', '%s', '%s', '%s', %s, %s, %s, %s);" % ( parms[2], row[0], row[1], unicode(row[2]), row[3], row[4], row[5], row[6], row[7] )
			self.conn.local_execute_sql_noreturn(sql_sentence)

	"""
		parms = ( from_date, to_date )
	"""
	def runner(self, parms):
		ext_parms = parms + ( 1, )
		self.create_stops(ext_parms)
		self.create_counts(ext_parms)
		self.create_equipments(ext_parms)
		self.create_prodtimes(ext_parms)
		self.create_setup_and_starts(ext_parms)
