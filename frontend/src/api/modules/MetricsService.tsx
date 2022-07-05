import Metric from 'types/Metric';
import BaseService from 'api/BaseService'

export default class MetricsService extends BaseService<Metric> {
  protected URL = 'metrics'

  public async index(
    params: {
      group_by?: string,
      filter?: {
        datetime_from: string,
        datetime_until: string
      }
    } = {}
  ) {
    return super.index(params)
  }
}

