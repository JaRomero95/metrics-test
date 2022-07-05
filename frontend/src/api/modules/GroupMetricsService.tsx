import BaseService from 'api/BaseService'

export default class GroupMetricsService extends BaseService<any> {
  protected URL = 'group_metrics'

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

