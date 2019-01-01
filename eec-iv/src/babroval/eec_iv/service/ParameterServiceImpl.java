package babroval.eec_iv.service;

import java.util.List;

import babroval.eec_iv.dao.Dao;
import babroval.eec_iv.dao.ParameterDaoImpl;

public class ParameterServiceImpl<T> implements Service<T> {
	
	@SuppressWarnings("unchecked")
	private Dao<T> dao = (Dao<T>) new ParameterDaoImpl();

	@Override
	public List<T> getAllFaults(String csvFilePath) {
		return dao.loadAllFaults(csvFilePath);
	}

	@Override
	public List<T> getAllParameters(String csvFilePath, StringBuffer data) {
		return dao.loadAllParameters(csvFilePath, data);
	}

}
