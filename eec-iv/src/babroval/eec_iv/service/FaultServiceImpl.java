package babroval.eec_iv.service;

import java.util.List;

import babroval.eec_iv.dao.Dao;
import babroval.eec_iv.dao.FaultDaoImpl;
import babroval.eec_iv.model.Fault;

public class FaultServiceImpl implements Service<Fault> {

	private Dao<Fault> dao = new FaultDaoImpl();

	@Override
	public List<Fault> getAll(String csvFilePath) {
		return dao.loadAll(csvFilePath);
	}

	@Override
	public List<Fault> updateAll(List<Fault> list, StringBuffer data) {
		throw new UnsupportedOperationException("Method has not implemented yet");
	}
}
